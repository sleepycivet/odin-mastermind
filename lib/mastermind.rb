require 'colorize'
require 'colorized_string'
require_relative './mastermind/text'
require_relative './mastermind/colorize'
require_relative 'mastermind/convert'

class Game
  include Text
  include Colorize
  include Convert

  def start_game
    text_game_rules
    code = create_code
    guess = nil

    loop do
      while guess.class != Array do
        guess = prompt_input
      end

      @guesses_count += 1

      puts "Guess ##{@guesses_count}: " +  convert_to_colored_text(guess) + " = Hint: " + convert_hint_to_colored_text(check_guess_to_code(code, guess))

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

  def computer_guess(code)
    is_guess_correct = false
    guess = nil # actual value
    guesses_count = 1
    combination_array = []

    # Create a guesses array of all possible codes
    guesses = generate_guesses
    puts "guesses.length = #{guesses.length}"

    while is_guess_correct == false do

      if guess == nil
        # If it's the first guess, use [1,1,2,2]
        guess = [1,1,2,2]
      else
        # Otherwise, pick a random index from guesses array
        guess = guesses[rand(guesses.length - 1)]
      end

      hint = check_guess_to_code(code, guess)
    
      puts "guess ##{guesses_count} = #{convert_to_colored_text(convert_indices_to_colors(guess))}; hint = #{convert_hint_to_colored_text(hint)} "

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
        puts "guesses is now #{guesses.length} long"
      end

      guesses_count += 1
    end

    return convert_indices_to_colors(guess)
  end
  
  def check_guess_to_code(code_arr, guess_arr)
    hints_array = []
    guess = guess_arr
    temp_code_arr = []
    code_arr.map{|element| temp_code_arr.push(element)}

    if guess_arr[0].class == Integer
      guess = convert_indices_to_colors(guess_arr)
    end

    guess.each_with_index do |element, index|
      if element == temp_code_arr[index]
        hints_array.push("O")
        temp_code_arr[index] = nil
      elsif temp_code_arr.include?(element)
        hints_array.push("X")
        temp_code_arr[temp_code_arr.find_index(element)] = nil
      else
        hints_array.push("-")
      end
    end

    return hints_array.shuffle!
  end

  def prompt_input
    text_prompt_input
    begin
      input = gets.upcase.chomp
      input = input.split('')
    rescue
      puts "Not a valid input."
    else
      if input.length == 4 && COLORS.include?(input[0]) && COLORS.include?(input[1]) && COLORS.include?(input[2]) && COLORS.include?(input[3])
        return input
      else
        puts "Not a valid input."
      end
    end
  end

  def create_code
    code = []
    4.times do
      code.push(COLORS[rand(6)])
    end
    # puts "The secret code is #{convert_to_colored_text(code)} which is #{convert_colors_to_indices(code)}"
    return code
  end


  protected
  COLORS = ["R", "G", "B", "C", "M", "Y"]

  def initialize
    @guesses_count = 0
  end
end