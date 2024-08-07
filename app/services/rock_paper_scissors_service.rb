class RockPaperScissorsService
  TIE = 'tie'.freeze
  USER_WON = 'user_won'.freeze
  CURB_WON = 'curb_won'.freeze
  ERROR = 'error'.freeze

  ROCK = 'rock'.freeze
  PAPER = 'paper'.freeze
  SCISSORS = 'scissors'.freeze

  CHOICES = {
    ROCK => 0,
    PAPER => 1,
    SCISSORS => 2,
  }.freeze

  def self.get_winner(raw_user_choice, raw_curb_choice)
    user_choice = raw_user_choice.to_s.downcase
    curb_choice = raw_curb_choice.to_s.downcase
    return ERROR unless CHOICES.keys.include?(user_choice) && CHOICES.keys.include?(curb_choice)
    return TIE if user_choice == curb_choice
    if CHOICES[user_choice] == (CHOICES[curb_choice] + 1) % 3
      USER_WON
    elsif CHOICES[curb_choice] == (CHOICES[user_choice] + 1) % 3
      CURB_WON
    else
      ERROR
    end
  end
end
