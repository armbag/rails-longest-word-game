require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split('')
    @answer = params[:answer].upcase
    @score = @answer.length
    @exist = exist?(@letters, @answer)
    @english = english_word?(@answer)
  end

private

  def exist?(letters, answer)
    p letters
    p answer
    p answer.chars.all? { |letter| answer.count(letter) <= letters.count(letter) }
    answer.chars.all? { |letter| answer.count(letter.downcase) <= letters.count(letter) }
  end

  def english_word?(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
