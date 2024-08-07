class CurbService
  MOCK_SERVER_URL = 'https://private-anon-42e6a468b0-curbrockpaperscissors.apiary-mock.com'.freeze
  PROXY_SERVER_URL = 'https://private-anon-42e6a468b0-curbrockpaperscissors.apiary-proxy.com'.freeze
  PROD_SERVER_URL = 'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com'.freeze

  TIMEOUT = 1.freeze

  attr_reader :server_url

  def initialize(server_url = MOCK_SERVER_URL)
    @server_url = server_url
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

  def retrieve_curb_throw
    if server_url.blank?
      log("No server selected", :warn)
      return
    end
    conn = Faraday.new(
      url: server_url,
      headers: {'Content-Type' => 'application/json'},
      request: { timeout: TIMEOUT },
    )
    response = conn.get('/rps-stage/throw')
    json_body = JSON.parse(response.body) rescue { message: "Failed to parse" }
    log("Response from game server. Status: #{response.status}, body: #{json_body}")
    if response.status == 200 && json_body['statusCode'] == 200
      json_body['body']
    end
  rescue Faraday::Error => e
    log("Failed to fetch the result. Error: #{e.message}", :error)
    nil
  end

  def retrieve_local_throw
    RockPaperScissorsService::CHOICES.keys.sample
  end

  def log(message, level = :info)
    Rails.logger.tagged(self.class.name) do
      Rails.logger.send(level, message)
    end
  end
end
