module Prompt
  COLORS = ["R", "G", "B", "C", "M", "Y"]

  def prompt_guess
    text_prompt_guess
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
end