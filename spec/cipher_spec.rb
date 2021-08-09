require './cipher'
require './shift_key'
require './shift_offset'
require 'pry'

RSpec.describe Cipher do
  before(:each) do
    @shift_key = ShiftKey.new("12345")
    @shift_offset = ShiftOffset.new("111111")
    @cipher = Cipher.new("Party time.", @shift_key, @shift_offset)
  end

  it 'exists and has attributes' do
    expect(@cipher).to be_a(Cipher)
    expect(@cipher.key).to eq(@shift_key)
    expect(@cipher.offset).to eq(@shift_offset)
  end

  it 'has shifts' do
    result = {"A" => 13,
              "B" => 24,
              "C" => 35,
              "D" => 46}
    expect(@cipher.shifts).to eq(result)
  end

  it 'splits message into four arrays' do
    result = ["p", "a", "r", "t", "y", " ", "t", "i", "m", "e", "."]
    expect(@cipher.split_message).to eq(result)
  end

  it 'has message hash' do
    result = {"A" => ["p", "y", "m"],
              "B" => ["a", " ", "e"],
              "C" => ["r", "t", "."],
              "D" => ["t", "i", nil]}
    expect(@cipher.message_hash).to eq(result)
  end

  it 'has normalized hash' do
    result = {"A" => ["p", "y", "m"],
              "B" => ["a", " ", "e"],
              "C" => ["r", "t", "."],
              "D" => ["t", "i"]}
    expect(@cipher.normalized_hash).to eq(result)
  end

  it 'can shift' do
    letters = ["p", "y", "m"]
    expect(@cipher.shift("A", letters)).to eq(["b", "k", "z"])
  end

  it 'has encrypted hash' do
    result = {"A" => ["b", "k", "z"],
              "B" => ["y", "x", "b"],
              "C" => ["z", "a", "."],
              "D" => ["l", "a"]}
    expect(@cipher.encrypted_hash).to eq(result)
  end

  it 'uses single array to add to string' do
    string = ""
    arr1 = @cipher.encrypted_hash["A"]
    @cipher.arr_to_string(string, arr1)
    expect(string).to eq("b")
  end

  it 'uses multiple arrays to return string' do
    string = ""
    arr1 = @cipher.encrypted_hash["A"]
    arr2 = @cipher.encrypted_hash["B"]
    arr3 = @cipher.encrypted_hash["C"]
    arr4 = @cipher.encrypted_hash["D"]
    @cipher.arrays_to_string(string, arr1, arr2, arr3, arr4)
    expect(string).to eq("byzl")
  end

  it 'has encrypted message' do
    result = "byzlkxaazb."
    expect(@cipher.encrypted_message).to eq(result)
  end
end
