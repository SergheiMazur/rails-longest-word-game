require 'open-uri'
require 'json'

class GamesController < ApplicationController
 def new
   @letters = generate_grid(10)
 end

 def score
   @word = params[:word].split("")
   @response = ""
   if english_word?(@word.join)

     @letters = params[:letters_array].downcase.split("")
     @word.each do |char|
       index = @letters.find_index { |letter| letter == char }
       if !index.nil?
         @letters.delete_at(index)
       end
     end
       if @letters.length + @word.length == params[:letters_array].length
         @response = "Well done your score is #{@word.length}"
       else
         @response = "These letters are not in the game"
       end
     else
       @response = "This is not a word"
     end
  end

 def english_word?(word)
   response = open("https://wagon-dictionary.herokuapp.com/#{word}")
   json = JSON.parse(response.read)
   return json['found']
 end

 def generate_grid(grid_size)
   Array.new(grid_size) { ('A'..'Z').to_a.sample }
 end
end
