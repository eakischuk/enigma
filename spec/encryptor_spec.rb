require 'spec_helper'

RSpec.describe Encryptor do
  before(:each) do
    @encryptor = Encryptor.new("Party time!", "12345", "111111")
  end

  xit 'exists and has attributes' do
    expect(@encryptor).to be_a(Encryptor)
    result = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
              "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
              "y", "z", " "]
    expect(@encryptor.range).to eq(result)
    expect(@encryptor.message).to eq("Party time!")
    expect(@encryptor.key).to be_a(ShiftKey)
    expect(@encryptor.key.shift_key).to eq("12345")
    expect(@encryptor.date).to be_a(ShiftOffset)
    expect(@encryptor.date.date).to eq("111111")
  end

  xit 'can shift' do
    letters = ["p", "y", "m"]
    expect(@encryptor.shift("A", letters)).to eq(["b", "k", "z"])
  end

  xit 'has encrypted hash' do
    result = {"A" => ["b", "k", "z"],
              "B" => ["y", "x", "b"],
              "C" => ["z", "a", "."],
              "D" => ["l", "a"]}
    expect(@ecryptor.encrypted_hash).to eq(result)
  end

  xit 'has encrypted message' do
    result = {encryption: "byzlkxaazb.", key: "12345", date: "111111"}
    expect(@encryptor.encrypted_message).to eq(result)
  end
end
