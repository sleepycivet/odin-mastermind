require 'colorize'
require 'colorized_string'
require_relative './mastermind/text'
require_relative './mastermind/colorize'
require_relative 'mastermind/convert'
require_relative 'mastermind/prompt'
require_relative 'mastermind/constants'

class Game
  include Text
  include Colorize
  include Convert
  include Prompt
  include Constants

  def start_game
    text_game_rules

    game_type = prompt_game_type
    @game_difficulty = prompt_difficulty

    if game_type == 'player'
      text_computer_guess_game
      text_game_difficulty(@game_difficulty)
      text_prompt_code
      player_code = prompt_rgbcmy
      puts text_player_code + convert_to_colored_text(player_code)
      if @game_difficulty == 'hard'
        computer_guess_hard(player_code)
      elsif @game_difficulty == 'easy'
      end
    elsif game_type == 'computer'
      text_player_guess_game
      text_game_difficulty(@game_difficulty)
      player_guess
    end

  end

  def player_guess
    code = create_code
    guess = nil

    loop do
      text_prompt_guess
      guess = prompt_rgbcmy

      @guesses_count += 1

      text_guess_and_hint(@guesses_count, guess, check_guess_to_code(code, guess))

      break if @guesses_count == 13 || check_guess_to_code(code, guess) == ["O", "O", "O", "O"]

      guess = nil
    end

    if check_guess_to_code(code, guess) == ["O", "O", "O", "O"]
      puts "Congrats! You win!"
    elsif @guesses_count == 13
      puts "You weren't able to guess the code in 12 tries. ;_;"
    end

    puts "The code was #{convert_to_colored_text(code)}"
    @guesses_count = 0
  end
  
  def generate_guesses
    # The solution says 1111 to 6666 but, taking into account that indices start from 0, our range would actually be from 0000 to 5555
    count = 0
    possible_codes =[]
    while count < 9999
      has_6789 = false
      count += 1
      temp_number = count.to_s.split("")

      while temp_number.length < 4 do
        temp_number.unshift("0")
      end

      temp_number.map!{|element| element.to_i}
      
      temp_number.each do |element|
        if element > 5
          has_6789 = true
        end
      end
      if has_6789 == false
        possible_codes.push(temp_number)
      end
    end
    possible_codes.unshift([0,0,0,0])
    return possible_codes
  end

  def computer_guess_easy(code)
    @game_difficulty = 'easy' # for testing
    is_guess_correct = false
  
    guesses_indices_array = [
      [0,1,2,3,4,5],
      [0,1,2,3,4,5],
      [0,1,2,3,4,5],
      [0,1,2,3,4,5]
    ]
    # pos0 = [0,1,2,3,4,5]
    # pos1 = [0,1,2,3,4,5]
    # pos2 = [0,1,2,3,4,5]
    # pos3 = [0,1,2,3,4,5]

    guess = [0,0,1,1]

    while is_guess_correct == false do
      hint = check_guess_to_code(code, guess)
      puts "code = #{code}"
      puts "guess = #{guess} which is #{convert_indices_to_colors(guess)}"
      puts "hint = #{hint}"
      puts "guess_indices_array starts at"
      p guesses_indices_array

      if hint == ['O', 'O', 'O', 'O']
        puts "it's all correct!!!"
        is_guess_correct = true
      else
        hint.each_with_index do |element, index|
          puts "hint at index #{index} = #{element}"
          if element == 'O'
            puts "element = 'O'"
            guesses_indices_array[index] = [guess[index]]
            puts "guesses_indices_array now equals"
            p guesses_indices_array
          elsif element == 'X'
            guesses_indices_array[index].delete_at(guesses_indices_array[index].find_index(guess[index]))
            guesses_indices_array.each
          end
        end
      end
      is_guess_correct = true # stop loop for testing
    end

    # Another way to implement this guessing is to have an array of possible indices for each position.
    # If it returns 'O' for that position, throw out all other elements in the indices array
    # If it returns 'X' select that element for a different location
    # If it returns '-' remove that element from indices array
    # Otherwise, choose a random index from the indices array for a guess
    return convert_indices_to_colors(guess)
  end

  def computer_guess_hard(code)
    is_guess_correct = false
    guess = nil # actual value
    guesses_count = 1
    combination_array = []

    # Create a guesses array of all possible codes
    guesses = generate_guesses

    while is_guess_correct == false do

      if guess == nil
        # If it's the first guess, use [1,1,2,2]
        guess = [1,1,2,2]
      else
        # Otherwise, pick a random index from guesses array
        guess = guesses[rand(guesses.length - 1)]
      end

      hint = check_guess_to_code(code, guess)

      text_guess_and_hint(guesses_count, convert_indices_to_colors(guess), hint)

      if hint == ['O', 'O', 'O', 'O']
        # If it's correct, end
        is_guess_correct = true

      elsif hint == ['-', '-', '-', '-']
        # If it's all wrong, delete any guesses with the indices 
        guess = guess.uniq
        wrong_guesses = []

        guess.each do |guess_element|
          guesses.each do |guesses_element|
            if guesses_element.include?(guess_element)
              wrong_guesses.push(guesses_element)
            end
          end
        end
        guesses = guesses - wrong_guesses
      
      elsif hint.include?('-') == false && combination_array.length < 1
        # If no colors are wrong (but some are in the wrong position),

        number_of_combinations = case guess.uniq.length
        when 4 then 24 # 4 unique digits = 24 possible combos
        when 3 then 12 # 3 unique digits = 12 possible combos
        when 2 then 4 # 2 unique digits = 4 possible combos
        end
        
        # return an array of the combination of all the possible answers
        while combination_array.length < number_of_combinations do
          shuffled_guess = guess.shuffle
          if combination_array.include?(shuffled_guess) == false
            combination_array.push(shuffled_guess)
          end
        end

        guesses = combination_array
      
      else
        # Else just delete the guess we did
        guesses.delete_at(guesses.find_index(guess))
      end

      guesses_count += 1
    end

    return convert_indices_to_colors(guess)
  end
  
  def check_guess_to_code(code_arr, guess_arr)
    hints_array = [nil, nil, nil, nil]
    guess = guess_arr
    temp_code_arr = []
    code_arr.map{|element| temp_code_arr.push(element)}

    if guess_arr[0].class == Integer
      guess = convert_indices_to_colors(guess_arr)
    end
    
    # Evaluate and remove exact matches (right color, right location)
    guess.each_with_index do |element, index|
      if element == temp_code_arr[index]
        hints_array[index] = "O"
        temp_code_arr[index] = nil
      end
    end

    # Find and remove almost correct matches (right color, wrong location)
    guess.each_with_index do |element,index|
      if hints_array[index] == 'O'
      elsif temp_code_arr.include?(element)
        hints_array[index] = "X"
        temp_code_arr[temp_code_arr.find_index(element)] = nil
      end
    end

    # Fill the rest of hints_array with wrong answer markers
    hints_array.each_with_index do |element, index|
      if element == nil
        hints_array[index] = "-"
      end
    end

    # Shuffle the hints array if the game difficulty is hard
    if @game_difficulty == 'hard'
      return hints_array.shuffle!
    else
      return hints_array
    end
  end

  def create_code
    code = []
    4.times do
      code.push(all_colors[rand(6)])
    end
    return code
  end


  protected

  def initialize
    @guesses_count = 0
    @game_difficulty = 'easy'
  end
end