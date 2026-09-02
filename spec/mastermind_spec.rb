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
      puts "subject.test_code[0] = #{test_code[0]}"
      expect(colors.include?(test_code[1])).to eq(true)
      puts "subject.test_code[1] = #{test_code[1]}"
      expect(colors.include?(test_code[2])).to eq(true)
      puts "subject.test_code[2] = #{test_code[2]}"
      expect(colors.include?(test_code[3])).to eq(true)
      puts "subject.test_code[3] = #{test_code[3]}"
    end
  end
end