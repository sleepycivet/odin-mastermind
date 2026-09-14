require_relative 'constants'

module Validate
  include Constants

  def validate_rgbcmy(arr)
    if all_colors.include?(arr[0]) && all_colors.include?(arr[1]) && all_colors.include?(arr[2]) && all_colors.include?(arr[3])
      true
    else
      false
    end
  end
end