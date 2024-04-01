class GuessesController < ApplicationController
  def index
    @guesses = Current.user.guesses.today
    @guess = Current.user.guesses.new

    @letters = [*('A'..'Z'), 'Æ', 'Ø', 'Å']

    puts ALLOWED_WORDS 
  end

  def create
    @guesses = Current.user.guesses.today
    @guess = Current.user.guesses.new(guess_params)
    if @guess.save
      redirect_to guesses_url
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
    def guess_params
      params.require(:guess).permit(:word)
    end
end
  