require_relative 'text'

module Prompt
  include Text
  COLORS = ["R", "G", "B", "C", "M", "Y"]

  def prompt_guess
    text_prompt_guess
    guess = nil

    while guess.class != Array do
      begin
      input = gets.upcase.chomp
      input = input.split('')
      rescue
        puts "Not a valid input."
      else
        if input.length == 4 && COLORS.include?(input[0]) && COLORS.include?(input[1]) && COLORS.include?(input[2]) && COLORS.include?(input[3])
          guess = input
        else
          puts "Not a valid input."
        end
      end
    end

    return guess
  end

  def prompt_game_type
    text_prompt_game_type
    game_type = nil

    while game_type == nil do
      begin
      input = gets.upcase.to_s.chomp
      rescue
        puts 'Please type "player" or "computer" to choose the game type.'
      else
        if input == 'PLAYER'
          game_type = 'player'
        elsif input == 'COMPUTER'
          game_type = 'computer'
        else
          puts 'Please type "player" or "computer" to choose the game type.'
        end
      end
    end

    return game_type
  end
end