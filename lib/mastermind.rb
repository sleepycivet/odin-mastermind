require 'colorize'
require 'colorized_string'

puts "WELCOME TO MASTERMIND!"
puts " "
puts "This is a game where you guess a secret code comprised of four of the following colors in a specific order:"
puts " "
puts "Red (henceforth R)".colorize(:background => :red)
puts "Green (henceforth G)".colorize(:background => :green)
puts "Blue (henceforth B)".colorize(:background => :blue)
puts "Cyan (henceforth C)".colorize(:background => :cyan)
puts "Magenta (henceforth M)".colorize(:background => :magenta)
puts "Yellow (henceforth Y)".colorize(:background => :yellow)
puts " "
puts "Of course, you will need a way to know how close your guess is to the answer. After each guess you will be shown the following markers. The position of these markers do not correlate with the positions of the guess."
puts " "
puts "X".colorize(:red).colorize(:background => :white) + " means that there is one correct color in the correct place"
puts "X".colorize(:black).colorize(:background => :white) + " means that there is one correct color but in the wrong place"

# Colors: R, G, B, C, M, Y

# Guess 01: R | _ | _ | _