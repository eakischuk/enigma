require './shift_offset'
require 'pry'

RSpec.describe ShiftOffset do
  before(:each) do
    @shift_offset = ShiftOffset.new("080721")
  end

  it 'exists and has attributes' do
    expect(@shift_offset).to be_a(ShiftOffset)
  end
end
