require 'spec_helper'

RSpec.describe ShiftOffset do
  before(:each) do
    @shift_offset1 = ShiftOffset.new("080721")
    @shift_offset2 = ShiftOffset.new
  end

  it 'exists and has attributes' do
    expect(@shift_offset1).to be_a(ShiftOffset)
    expect(@shift_offset1.date).to eq("080721")
  end

  it 'has split date' do
    expect(@shift_offset1.split_date).to eq(["0", "8", "0", "7", "2", "1"])
  end

  it 'has four offsets' do
    result = {"A" => 0,
              "B" => 7,
              "C" => 2,
              "D" => 1}
    expect(@shift_offset1.four_offsets).to eq(result)
  end
end
