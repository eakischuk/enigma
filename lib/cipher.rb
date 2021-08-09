require 'shift_key'
require 'shift_offset'

class Cipher
  attr_reader :key, :offset, :range

  def initialize(message, key, offset)
    @message = message
    @key = key
    @offset = offset
    @range = ("a".."z").to_a << " "
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

  def normalized_hash
    message_hash.transform_values do |value|
      value.delete_if do |letter|
        letter == nil
      end
    end
  end

  def shift(group, letter_array)
    letter_array.map do |letter|
      if @range.include?(letter)
        new_index = (@range.find_index(letter) + shifts[group]) % 27
        letter = @range[new_index]
      else
        letter
      end
    end
  end

  def encrypted_hash
    encrypted = Hash.new {|hash, key| hash[key] = []}
    normalized_hash.each_pair do |group, letters|
      encrypted[group] = shift(group, letters)
    end
    encrypted
  end

  def encrypted_message
    string = ""
    arr1 = encrypted_hash["A"]
    arr2 = encrypted_hash["B"]
    arr3 = encrypted_hash["C"]
    arr4 = encrypted_hash["D"]
    until arr1.empty? && arr2.empty? && arr3.empty? && arr4.empty?
      if !arr1.empty?
        string << arr1[0][-1]
        arr1.shift
      end
      if !arr2.empty?
        string << arr2[0][-1]
        arr2.shift
      end
      if !arr3.empty?
        string << arr3[0][-1]
        arr3.shift
      end
      if !arr4.empty?
        string << arr4[0][-1]
        arr4.shift
      end
    end
    string
  end
end
