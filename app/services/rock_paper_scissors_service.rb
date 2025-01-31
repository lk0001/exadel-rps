class RockPaperScissorsService
  TIE = 'tie'.freeze
  USER_WON = 'user_won'.freeze
  CURB_WON = 'curb_won'.freeze
  ERROR = 'error'.freeze

  ROCK = 'rock'.freeze
  PAPER = 'paper'.freeze
  SCISSORS = 'scissors'.freeze

  CHOICE_VALUES = {
    ROCK => 0,
    PAPER => 1,
    SCISSORS => 2,
  }.freeze
  CHOICES = CHOICE_VALUES.keys.freeze

  def self.get_winner(raw_user_choice, raw_curb_choice)
    user_choice = raw_user_choice.to_s.downcase
    curb_choice = raw_curb_choice.to_s.downcase
    return ERROR unless CHOICES.include?(user_choice) && CHOICES.include?(curb_choice)
    return TIE if user_choice == curb_choice
    if CHOICE_VALUES[user_choice] == (CHOICE_VALUES[curb_choice] + 1) % 3
      USER_WON
    elsif CHOICE_VALUES[curb_choice] == (CHOICE_VALUES[user_choice] + 1) % 3
      CURB_WON
    else
      ERROR
    end
  end

  # Note on adding a hammer
  # The implementation will depend on what's the behavior of the hammer, though I'd most likely still use the CHOICES array
  # and have a HAMMER const. The `get_winner` method will see more changes though:
  # 1. if hammer beats everything, we can just add a condition after checking for ties.
  # 2. if (for example) hammer beats rock and scissors but loses to paper, then current fancy implementation is
  #   not as good as the original one (where we simply looked at possible cases).
end
