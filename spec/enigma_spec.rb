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
    expect(@enigma.encrypt("PARTY TIME!", "12345", "111111")).to eq("byzlkxaazb!")
  end

  it 'can decrypt' do
    expect(@enigma.decrypt("byzlkxaazb!", "12345", "111111")).to eq("party time!")
  end
end
