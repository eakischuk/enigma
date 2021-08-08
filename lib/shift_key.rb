class ShiftKey
  attr_reader :shift_key
  def initialize(key = ["0", "1", "2", "3", "4", "5", "6", "7", "8","9"].sample(5).join)
    @shift_key = key
  end
end
