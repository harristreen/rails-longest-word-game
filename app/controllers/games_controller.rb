require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = 8.times.map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @attempt = params[:guess]
    attempt_a = @attempt.upcase.chars
    if (attempt_a.all? { |c| (attempt_a.count(c) <= params[:grid].count(c)) && params[:grid].include?(c) }) == false
      @message = 'Character used that is not in the grid.'
    elsif compare_to_dictionary(@attempt) == false
      @message = 'Not an english word'
    else
      @message = 'Well done!'
    end
  end

  def compare_to_dictionary(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    dictionary_serialized = URI.open(url).read
    dictionary = JSON.parse(dictionary_serialized)
    dictionary['found']
  end
end
