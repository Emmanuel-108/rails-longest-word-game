class GamesController < ApplicationController
  def new
    letter = ('A'..'Z').to_a
    @grid = ''
    i = 0

    while i < 10
      @grid += letter.sample
      i += 1
    end
    @grid = @grid.chars
  end

  def score
    @word = params[:word]
  end
end
