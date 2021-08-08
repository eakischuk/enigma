require '/shift_key'
require 'pry'

RSpec.describe ShiftKey do
  before(:each) do
    @shift_key = ShiftKey.new
  end

  it 'exists and has attributes' do
    expect(@shift_key).to be_a(ShiftKey)
  end
end
