require 'colorize'
require 'colorized_string'
require_relative './mastermind/text'
require_relative './mastermind/display'

class Game
  include Text
  include Display

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
  
  def generate_codes
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
    # print possible_codes.map{|element| element.join("")}
    return possible_codes
  end

  def computer_guess(code)
    computer_answer = nil
    is_guess_correct = false
  
    guesses = generate_codes
    puts "guess starts as #{guesses.length} long"
    # print guesses.map{|element| element.join("").to_i}

    while is_guess_correct == false do
      puts "while!"
      puts "computer_answer = #{computer_answer}"

      if computer_answer == nil
        puts "computer_answer == nil"
        computer_answer = convert_indices_to_colors([1,1,2,2])
      else
        puts "computer_answer != nil"
        random_guess = guesses[rand(guesses.length - 1)]
        puts "random_guess = #{random_guess}"
        computer_answer = convert_indices_to_colors(random_guess)
      end

      puts "computer_answer = #{computer_answer}"

      puts "hints = #{check_guess_to_code(code, computer_answer)}"

      if check_guess_to_code(code,computer_answer) == ['O', 'O', 'O', 'O']
        puts " it was ['O', 'O', 'O', 'O'] so yaaaay it's correct"
        is_guess_correct = true
      elsif check_guess_to_code(code,computer_answer) == ['X', 'X', 'X', 'X']
        puts "it was ['X', 'X', 'X', 'X']"
        indiced_computer_answer = convert_colors_to_indices(computer_answer)

        guesses_with_wrongs = []

        indiced_computer_answer.each do |element|
          guesses.each do |guess|
            if guess.include?(element)
              guesses_with_wrongs.push(guess)
            end
          end
        end

        guesses = guesses - guesses_with_wrongs
        # puts 'guesses after all them removed'
        # print guesses.map{|element| element.join("")}

      elsif check_guess_to_code(code,computer_answer).include?("X") == false
        puts "the hint had no Xs"

        guesses.delete_at(guesses.find_index(convert_colors_to_indices(computer_answer)))

        guesses_with_rights = []
        
        indiced_computer_answer = convert_colors_to_indices(computer_answer)
        puts "indiced_computer_answer = #{indiced_computer_answer}"

        guesses.each do |guess|
          # puts "*****"
          # puts "guess = #{guess}"
          # puts "indiced_computer_answer = #{indiced_computer_answer}"
          # puts "guess.difference(indiced_computer_answer) == #{guess.difference(indiced_computer_answer)}"
          
          if guess.difference(indiced_computer_answer).length < 1
            # puts "true so guess of #{guess} is pushed to guesses_with_rights"
            guesses_with_rights.push(guess)
          end
        end

        # print guesses_with_rights.map{|element| element.join("")}
        # puts ""
        # puts "indiced_computer_answer = #{indiced_computer_answer}"

        # indiced_computer_answer.each do |element|
        #   puts "the element is #{element}"
        #   guesses.each do |guess|
        #     puts "the guess is #{guess}"
        #     if guess.include?(element)
        #       puts "#{guess} includes #{element} and is pushed to guesses_with_rights"
        #       guesses_with_rights.push(guess)
        #     end
        #   end
        # end

        # puts "not included"
        # print (guesses - guesses_with_rights).map{|element| element.join("")}
        # puts "guesses_with_rights = "
        # print guesses_with_rights.map{|element| element.join("")}
        # guesses = []
        # guesses = guesses_with_rights
        # puts "guesses is now"
        # print guesses.map{|element| element.join("")}
        guesses = guesses_with_rights
        puts "guesses is now"
        print guesses.map{|element| element.join("")}
        puts ""
        puts "indiced_computer_answer = #{indiced_computer_answer}"
        # is_guess_correct = true
      else
        puts "elseeee delete that one item"
        puts "the index of computer_answer #{computer_answer} in guesses is #{guesses.find_index
        (convert_colors_to_indices(computer_answer))}"
        
        guesses.delete_at(guesses.find_index(convert_colors_to_indices(computer_answer)))
      end
      puts "now guesses is #{guesses.length} long"
      # print guesses.map{|element| element.join("").to_i}
    end
    return computer_answer
  end

  def convert_indices_to_colors(array)
    colors = ["R", "G", "B", "C", "M", "Y"]
    color_array = []

    array.each do |element|
      color_array.push(colors[element])
    end
    return color_array
  end

  def convert_colors_to_indices(array)
    colors = ["R", "G", "B", "C", "M", "Y"]
    indices_array = []
      array.each do |element|
      indices_array.push(colors.find_index(element))
    end
    return indices_array
  end

  def check_guess_to_code(code_arr, guess_arr)
    hints_array = []
    
    guess_arr.each_with_index do |element, index|
      if element == code_arr[index]
        hints_array.push("O")
      elsif code_arr.include?(element)
        hints_array.push("-")
      else
        hints_array.push("X")
      end
    end
    return hints_array.shuffle!
  end

  def prompt_input
    colors = ["R", "G", "B", "C", "M", "Y"]
    text_prompt_input
    begin
      input = gets.upcase.chomp
      input = input.split('')
    rescue
      puts "Not a valid input."
    else
      if input.length == 4 && colors.include?(input[0]) && colors.include?(input[1]) && colors.include?(input[2]) && colors.include?(input[3])
        return input
      else
        puts "Not a valid input."
      end
    end
  end

  def convert_hint_to_colored_text(array)
    color_string = ""
    array.each do |element|
      case element
      when 'O'
        color_string.concat("#{display_correct}")
      when '-'
        color_string.concat("#{display_almost_correct}")
      when 'X'
        color_string.concat("#{display_wrong}")
      end
    end
    return color_string
  end

  def convert_to_colored_text (array)
    color_string = ""
    array.each_with_index do |element, index|
      case element
      when 'R'
        color_string.concat("#{display_red}")
      when 'G'
        color_string.concat("#{display_green}")
      when 'B'
        color_string.concat("#{display_blue}")
      when 'C'
        color_string.concat("#{display_cyan}")
      when 'M'
        color_string.concat("#{display_magenta}")
      when 'Y'
        color_string.concat("#{display_yellow}")
      end

      if index < (array.length - 1)
        color_string.concat (" | ")
      end
    end
    return color_string
  end

  def create_code
    code = []
    colors = ["R", "G", "B", "C", "M", "Y"]
    4.times do
      code.push(colors[rand(6)])
    end
    # puts "The secret code is #{convert_to_colored_text(code)}"
    return code
  end


  protected

  def initialize
    @guesses_count = 0
  end
end