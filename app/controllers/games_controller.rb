class GamesController < ApplicationController
  def index
  end

  def create
    # TODO use external service instead of local fallack
    curb_choice = CurbService.new(nil).retrieve_throw
    user_choice = params[:choice]

    winner = RockPaperScissorsService.get_winner(user_choice, curb_choice)

    respond_to do |format|
      format.html {
        redirect_to games_path, notice: "#{winner.humanize} (player's choice: #{user_choice}, Curb's choice: #{curb_choice}!"
      }
      format.json {
        render json: {
          curb_choice: curb_choice,
          user_choice: user_choice,
          winner: winner,
        }
      }
    end
  end
end
