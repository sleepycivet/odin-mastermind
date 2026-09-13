require './lib/mastermind.rb'
RSpec.describe 'Mastermind Game' do
  subject { Game.new}
  describe 'create secret code' do
    it 'returns an array of 4 elements' do
      expect(subject.create_code.length).to eq(4)
    end
    it 'returns an array with R,G,B,C,M,Y' do
      colors = ['R', 'G', 'B', 'C', 'M', 'Y']
      test_code = subject.create_code
      expect(colors.include?(test_code[0])).to eq(true)
      # puts "subject.test_code[0] = #{test_code[0]}"
      expect(colors.include?(test_code[1])).to eq(true)
      # puts "subject.test_code[1] = #{test_code[1]}"
      expect(colors.include?(test_code[2])).to eq(true)
      # puts "subject.test_code[2] = #{test_code[2]}"
      expect(colors.include?(test_code[3])).to eq(true)
      # puts "subject.test_code[3] = #{test_code[3]}"
    end
  end
  describe 'create code guesses' do
    it 'should be an array' do
      expect(subject.generate_codes).to be_an_instance_of(Array)
    end
    it 'should be 4 digits long' do
      expect(subject.generate_codes[10].length).to eq(4)
    end
    it 'should not include digits 6, 7, 8, or 9' do
      guesses = subject.generate_codes
      has_6789 = false
      guesses.each do |element|
        element.each do |item|
          if item > 6
            has_6789 = true
          end
        end
      end
      expect(has_6789).to eq(false)
    end
  end
  describe 'computer guesses player code' do
    it 'should create a color array from number array' do
      test_number_array = [1,1,2,2]
      expect(subject.convert_indices_to_colors(test_number_array)).to eq(["G", "G", "B", "B"])
    end
    it 'should create an indices array from color array' do
      test_color_array = ["R", "C", "G", "R"]
      expect(subject.convert_colors_to_indices(test_color_array)).to eq([0,3,1,0])
    end
    it 'should stop when the guess matches the code' do
      test_code = subject.create_code
      expect(subject.computer_guess(test_code)).to eq(test_code)
    end
  end
end