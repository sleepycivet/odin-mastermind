require_relative 'colorize'
require_relative 'constants'

module Convert
  include Colorize
  include Constants

  def convert_hint_to_colored_text(array)
    color_string = ""
    array.each do |element|
      case element
      when 'O'
        color_string.concat("#{colorize_correct}")
      when 'X'
        color_string.concat("#{colorize_almost_correct}")
      when '-'
        color_string.concat("#{colorize_wrong}")
      end
    end
    return color_string
  end

  def convert_to_colored_text (array)
    color_string = ""
    array.each_with_index do |element, index|
      case element
      when 'R'
        color_string.concat("#{colorize_red}")
      when 'G'
        color_string.concat("#{colorize_green}")
      when 'B'
        color_string.concat("#{colorize_blue}")
      when 'C'
        color_string.concat("#{colorize_cyan}")
      when 'M'
        color_string.concat("#{colorize_magenta}")
      when 'Y'
        color_string.concat("#{colorize_yellow}")
      end

      if index < (array.length - 1)
        color_string.concat (" | ")
      end
    end
    return color_string
  end

  def convert_indices_to_colors(array)
    color_array = []

    array.each do |element|
      color_array.push(all_colors[element])
    end
    return color_array
  end

  def convert_colors_to_indices(array)
    indices_array = []
      array.each do |element|
      indices_array.push(all_colors.find_index(element))
    end
    return indices_array
  end

end