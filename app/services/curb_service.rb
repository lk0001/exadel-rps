class CurbService
  MOCK_SERVER_URL = 'https://private-anon-42e6a468b0-curbrockpaperscissors.apiary-mock.com'.freeze
  PROXY_SERVER_URL = 'https://private-anon-42e6a468b0-curbrockpaperscissors.apiary-proxy.com'.freeze
  PROD_SERVER_URL = 'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com'.freeze

  TIMEOUT = 5.freeze

  attr_reader :server_url

  def initialize(server = :prod)
    @server_url = case server
    when :prod
      log("Using production server")
      PROD_SERVER_URL
    when :proxy
      log("Using proxy server")
      PROXY_SERVER_URL
    when :mock
      log("Using mock server")
      MOCK_SERVER_URL
    when :local
      log("Using local results")
      nil
    else
      log("Using production server")
      PROD_SERVER_URL
    end
  end

  def retrieve_throw
    curb_throw = retrieve_curb_throw
    if curb_throw
      log("Received result from game server: #{curb_throw}")
      curb_throw
    else
      local_throw = retrieve_local_throw
      log("Falling back to local result: #{local_throw}")
      local_throw
    end
  end

  def retrieve_curb_response
    if server_url.blank?
      log("No server selected", :warn)
      return
    end
    conn = Faraday.new(
      url: server_url,
      headers: {'Content-Type' => 'application/json'},
      request: { timeout: TIMEOUT },
    )
    conn.get('/rps-stage/throw')
  rescue Faraday::Error => e
    log("Failed to fetch the result. Error: #{e.message}", :error)
    nil
  end

  def retrieve_curb_throw
    response = retrieve_curb_response
    return if response.blank?

    json_body = JSON.parse(response.body) rescue { message: "Failed to parse" }
    log("Response from game server. Status: #{response.status}, body: #{json_body}")
    if response.status == 200 && json_body['statusCode'] == 200
      json_body['body']
    end
  end

  def retrieve_local_throw
    RockPaperScissorsService::CHOICES.sample
  end

  def log(message, level = :info)
    Rails.logger.tagged(self.class.name) do
      Rails.logger.send(level, message)
    end
  end
end
