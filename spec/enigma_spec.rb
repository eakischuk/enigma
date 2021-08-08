require './cipher'
require './enigma'
require 'pry'

RSpec.describe Enigma do
  before(:each) do
    @enigma = Enigma.new
  end

  it 'exists and has attributes' do
    expect(@enigma).to be_an(Enigma)
  end
end
