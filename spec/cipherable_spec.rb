require 'spec_helper'

RSpec.describe Cipherable do
  include Cipherable
  before(:each) do
    @range = ("a".."z").to_a << " "
    @shift_key = ShiftKey.new("12345")
    @shift_offset = ShiftOffset.new("111111")
    @message = "Party time!"
  end

  xit 'has letter index within range' do
    expect(@cipher.letter_index("f")).to eq(5)
  end

  xit 'has shifts' do
    result = {"A" => 13,
              "B" => 24,
              "C" => 35,
              "D" => 46}
    expect(@cipher.shifts).to eq(result)
  end

  xit 'splits message into four arrays' do
    result = ["p", "a", "r", "t", "y", " ", "t", "i", "m", "e", "."]
    expect(@cipher.split_message).to eq(result)
  end

  xit 'has message hash' do
    result = {"A" => ["p", "y", "m"],
              "B" => ["a", " ", "e"],
              "C" => ["r", "t", "."],
              "D" => ["t", "i", nil]}
    expect(@cipher.message_hash).to eq(result)
  end

  xit 'has normalized hash' do
    result = {"A" => ["p", "y", "m"],
              "B" => ["a", " ", "e"],
              "C" => ["r", "t", "."],
              "D" => ["t", "i"]}
    expect(@cipher.normalized_hash).to eq(result)
  end


  xit 'uses single array to add to string' do
    string = ""
    arr1 = @cipher.encrypted_hash["A"]
    @cipher.arr_to_string(string, arr1)
    expect(string).to eq("b")
  end

  xit 'uses multiple arrays to return string' do
    string = ""
    arr1 = @cipher.encrypted_hash["A"]
    arr2 = @cipher.encrypted_hash["B"]
    arr3 = @cipher.encrypted_hash["C"]
    arr4 = @cipher.encrypted_hash["D"]
    @cipher.arrays_to_string(string, arr1, arr2, arr3, arr4)
    expect(string).to eq("byzl")
  end
end

# xit 'can shift' do
#   letters = ["p", "y", "m"]
#   expect(@cipher.shift("A", letters)).to eq(["b", "k", "z"])
# end
#
# it 'can unshift' do
#   letters = ["b", "k", "z"]
#   expect(@cipher.unshift("A", letters)).to eq(["p", "y", "m"])
# end

# it 'has encrypted message' do
#   result = {encryption: "byzlkxaazb.", key: "12345", date: "111111"}
#   expect(@cipher.encrypted_message).to eq(result)
# end
#
# it 'has decrypted message' do
#   result = {decryption: "party time.", key: "12345", date: "111111"}
#   expect(@decipher.decrypted_message).to eq(result)
# end
#
# it 'has encrypted hash' do
#   result = {"A" => ["b", "k", "z"],
#             "B" => ["y", "x", "b"],
#             "C" => ["z", "a", "."],
#             "D" => ["l", "a"]}
#   expect(@cipher.encrypted_hash).to eq(result)
# end
#
# it 'has decrypted hash' do
#   result = {"A" => ["p", "y", "m"],
#             "B" => ["a", " ", "e"],
#             "C" => ["r", "t", "."],
#             "D" => ["t", "i"]}
#   expect(@decipher.decrypted_hash).to eq(result)
# end
