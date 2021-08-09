require './cipher'
require './enigma'
require 'pry'

RSpec.describe Enigma do
  before(:each) do
    @enigma = Enigma.new
  end

  it 'exists' do
    expect(@enigma).to be_an(Enigma)
  end

  it 'can encrypt' do
    result = {encryption: "byzlkxaazb!", key: "12345", date: "111111"}
    expect(@enigma.encrypt("PARTY TIME!", "12345", "111111")).to eq(result)
  end

  it 'can decrypt' do
    result = {decryption: "party time!", key: "12345", date: "111111"}
    expect(@enigma.decrypt("byzlkxaazb!", "12345", "111111")).to eq(result)
  end
end
