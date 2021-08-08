require 'shift_key'
require 'shift_offset'

class Cipher
  attr_reader :key, :offset

  def initialize(message, key, offset)
    @message = message
    @key = key
    @offset = offset
    @range = ["a".."z" + " "]
  end

  def shifts
    shift = {}
    @key.four_keys.keys.each do |key|
      shift[key] = @key.four_keys[key] + @offset.four_offsets[key]
    end
    shift
  end

  def split_message
    @message.downcase.split(//)
  end

  def message_hash
    split = split_message
    message = Hash.new {|hash, key| hash[key] = []}
    until split.empty?
      message["A"] << split[0]
      split.shift
      message["B"] << split[0]
      split.shift
      message["C"] << split[0]
      split.shift
      message["D"] << split[0]
      split.shift
    end
    message
  end
end
