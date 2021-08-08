class ShiftKey
  attr_reader :shift_key
  def initialize(key = ["0", "1", "2", "3", "4", "5", "6", "7", "8","9"].sample(5).join)
    @shift_key = key
  end

  def split_key
    @shift_key.split(//)
  end

  def key_hash
    hash = Hash.new {|hash, key| hash[key] = []}
    hash["A"] << split_key[0]
    hash["A"] << split_key[1]
    hash["B"] << split_key[1]
    hash["B"] << split_key[2]
    hash["C"] << split_key[2]
    hash["C"] << split_key[3]
    hash["D"] << split_key[3]
    hash["D"] << split_key[4]
    hash
  end

  def four_keys
    key_hash.transform_values do |value|
      value.join.to_i
    end
  end
end
