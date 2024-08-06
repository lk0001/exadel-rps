class GamesController < ApplicationController
  def index
  end

  def create
    curb_choice = CurbService.new(nil).retrieve_throw
    user_choice = params[:choice]

    winner = RockPaperScissorsService.get_winner(user_choice, curb_choice)

    redirect_to games_path, notice: "#{winner.humanize} (player's choice: #{user_choice}, Curb's choice: #{curb_choice}!"
  end
end
