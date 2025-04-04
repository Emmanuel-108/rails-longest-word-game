require 'open-uri'
require 'json'
require 'date'
require 'time'

class GamesController < ApplicationController
  def new
    @grid = random_chars
    session[:grid] = @grid
  end

  def score
    @word = params[:word].upcase
    url = "https://dictionary.lewagon.com/#{@word}"
    json_file = URI.parse(url).read
    json_doc = JSON.parse(json_file)
    grid = session[:grid]

    @phrase = ''
    if !json_doc['found']
      @phrase = "Sorry bug #{@word} doesn't seem to be a valid English word."
    elsif json_doc['found'] && valid_chars?(@word, grid)
      @phrase = "Congratulations! #{@word} is a valida English word!"
    else
      @phrase = "Sorry but #{@word} can't be built out of: #{grid.join(', ')}"
    end
  end

  def random_chars
    letter = ('A'..'Z').to_a
    @grid = ''
    i = 0

    while i < 10
      @grid += letter.sample
      i += 1
    end

    @grid = @grid.chars
  end

  def valid_chars?(word, grid)
    grid.each do |letter|
      word = word.sub(letter, '') if word.include?(letter)
    end

    true if word.length.zero?
  end
end
