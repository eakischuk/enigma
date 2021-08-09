require 'spec_helper'

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

  it 'splits key into array' do
    expect(@shift_key2.split_key).to eq(["0", "9", "5", "6", "2"])
  end

  it 'has hash of split keys' do
    result = {"A" => ["0", "9"],
              "B" => ["9", "5"],
              "C" => ["5", "6"],
              "D" => ["6", "2"]}
    expect(@shift_key2.key_hash).to eq(result)
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
