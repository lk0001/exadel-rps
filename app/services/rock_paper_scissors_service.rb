class RockPaperScissorsService
  TIE = 'tie'.freeze
  USER_WON = 'user_won'.freeze
  CURB_WON = 'curb_won'.freeze
  ERROR = 'error'.freeze

  ROCK = 'rock'.freeze
  PAPER = 'paper'.freeze
  SCISSORS = 'scissors'.freeze

  CHOICES = [ROCK, PAPER, SCISSORS].freeze

  # maybe rework RPS to be numbers

  def self.get_winner(user_choice, curb_choice)
    return ERROR unless CHOICES.include?(user_choice) && CHOICES.include?(curb_choice)
    return TIE if user_choice == curb_choice
    case user_choice
    when ROCK
      curb_choice == PAPER ? CURB_WON : USER_WON
    when PAPER
      curb_choice == SCISSORS ? CURB_WON : USER_WON
    when SCISSORS
      curb_choice == ROCK ? CURB_WON : USER_WON
    else
      ERROR
    end
  end
end
