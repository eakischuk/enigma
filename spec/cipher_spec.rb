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
  end
end
