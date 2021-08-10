require 'spec_helper'

RSpec.describe Cipherable do
  include Cipherable
  before(:each) do
    @range = ("a".."z").to_a << " "
    @shift_key = ShiftKey.new("12345")
    @shift_offset = ShiftOffset.new("111111")
    @message = "Party time."
  end

  it 'has letter index within range' do
    expect(letter_index(@range, "f")).to eq(5)
  end

  it 'has shifts' do
    result = {"A" => 13,
              "B" => 24,
              "C" => 35,
              "D" => 46}
    expect(shifts(@range, @shift_key, @shift_offset)).to eq(result)
  end

  it 'splits message into four arrays' do
    result = ["p", "a", "r", "t", "y", " ", "t", "i", "m", "e", "."]
    expect(split_message(@message)).to eq(result)
  end

  it 'has message hash' do
    result = {"A" => ["p", "y", "m"],
              "B" => ["a", " ", "e"],
              "C" => ["r", "t", "."],
              "D" => ["t", "i", nil]}
    expect(message_hash(@message)).to eq(result)
  end

  it 'has normalized hash' do
    result = {"A" => ["p", "y", "m"],
              "B" => ["a", " ", "e"],
              "C" => ["r", "t", "."],
              "D" => ["t", "i"]}
    expect(normalized_hash(@message)).to eq(result)
  end


  it 'uses single array to add to string' do
    string = ""
    arr1 = message_hash(@message)["A"]
    arr_to_string(string, arr1)
    expect(string).to eq("p")
  end

  it 'uses multiple arrays to return string' do
    string = ""
    arr1 = message_hash(@message)["A"]
    arr2 = message_hash(@message)["B"]
    arr3 = message_hash(@message)["C"]
    arr4 = message_hash(@message)["D"]
    arrays_to_string(string, arr1, arr2, arr3, arr4)
    expect(string).to eq("part")
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
