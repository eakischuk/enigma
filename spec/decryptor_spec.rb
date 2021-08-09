require 'spec_helper'

RSpec.describe Decryptor do
  before(:each) do
    @decryptor = Decryptor.new("byzlkxaazb!", "12345", "111111")
  end

  xit 'exists and has attributes' do
    expect(@decryptor).to be_a(Decryptor)
    result = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
              "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
              "y", "z", " "]
    expect(@decryptor.range).to eq(result)
    expect(@decryptor.message).to eq("byzlkxaazb!")
    expect(@decryptor.key).to be_a(ShiftKey)
    expect(@decryptor.key.shift_key).to eq("12345")
    expect(@decryptor.date).to be_a(ShiftOffset)
    expect(@decryptor.date.date).to eq("111111")
  end

  xit 'can unshift' do
    letters = ["b", "k", "z"]
    expect(@decryptor.unshift("A", letters)).to eq(["p", "y", "m"])
  end

  xit 'has decrypted hash' do
    result = {"A" => ["p", "y", "m"],
              "B" => ["a", " ", "e"],
              "C" => ["r", "t", "."],
              "D" => ["t", "i"]}
    expect(@decryptor.decrypted_hash).to eq(result)
  end

  xit 'has decrypted message' do
    result = {decryption: "party time.", key: "12345", date: "111111"}
    expect(@decryptor.decrypted_message).to eq(result)
  end
end
