require '/shift_key'
require 'pry'

RSpec.describe ShiftKey do
  before(:each) do
    @shift_key1 = ShiftKey.new
    @shift_key2 = ShiftKey.new("09562")
  end

  it 'exists and has attributes' do
    expect(@shift_key1).to be_a(ShiftKey)
    expect(@shift_key1.shift_key).to be_a(String)
    expect(@shift_key2.shift_key).to eq("09562")
  end

  it 'has four keys' do
    result = {"A" => 9,
              "B" => 95,
              "C" => 56,
              "D" => 62
              }
    expect(@shift_key2.four_keys).to eq(result)
  end
end
