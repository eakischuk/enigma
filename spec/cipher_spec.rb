require './cipher'
require './shift_key'
require './shift_offset'
require 'pry'

RSpec.describe Cipher do
  before(:each) do
    @shift_key = ShiftKey.new("09218")
    @shift_offset = ShiftOffset.new("080721")
    @cipher = Cipher.new("The stoned ape hypothesis.", @shift_key, @shift_offset)
  end

  it 'exists and has attributes' do
    expect(@cipher).to be_a(Cipher)
    expect(@cipher.key).to eq(@shift_key)
    expect(@cipher.offset).to eq(@shift_offset)
  end

  it 'has shifts' do
    result = {"A" => 9,
              "B" => 99,
              "C" => 23,
              "D" => 19}
    expect(@cipher.shifts).to eq(result)
  end

  it 'splits message into four arrays' do
    result = ["t", "h", "e", " ", "s", "t", "o", "n", "e", "d", " ", "a", "p", "e", " ", "h", "y", "p", "o", "t", "h", "e", "s", "i", "s", "."]
    expect(@cipher.split_message).to eq(result)
  end

  it 'has message hash' do
    result = {"A" => ["t", "s", "e", "p", "y", "h", "s"],
      "B" => ["h", "t", "d", "e", "p", "e", "."],
      "C" => ["e", "o", " ", " ", "o", "s", nil],
      "D" => [" ", "n", "a", "h", "t", "i", nil]}
    expect(@cipher.message_hash).to eq(result)
  end
end
