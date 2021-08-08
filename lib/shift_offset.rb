require 'date'

class ShiftOffset
  attr_reader :date

  def initialize(date = (Date.today.to_s.delete_prefix("20").split("-")).reverse.join)
    @date = date
  end

  def split_date
    @date.split(//)
  end

  def four_offsets
    offsets = {}
    offsets["A"] = split_date[-4].to_i
    offsets["B"] = split_date[-3].to_i
    offsets["C"] = split_date[-2].to_i
    offsets["D"] = split_date[-1].to_i
    offsets
  end
end
