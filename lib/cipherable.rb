require './spec/spec_helper'

module Cipherable
  def letter_index(range, letter)
    range.find_index(letter)
  end

  def shifts(range, shift_key, shift_offset)
    shift = {}
    shift_key.four_keys.keys.each do |key|
      shift[key] = shift_key.four_keys[key] + shift_offset.four_offsets[key]
    end
    shift
  end

  def split_message(message)
    message.downcase.split(//)
  end

  def message_hash(message)
    split = split_message(message)
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

  def normalized_hash(message)
    message_hash(message).transform_values do |value|
      value.delete_if do |letter|
        letter == nil
      end
    end
  end

  def arr_to_string(str, arr)
    if !arr.empty?
      str << arr[0][-1]
      arr.shift
    end
  end

  def arrays_to_string(str, arr1, arr2, arr3, arr4)
    string = str
    arr_to_string(string, arr1)
    arr_to_string(string, arr2)
    arr_to_string(string, arr3)
    arr_to_string(string, arr4)
  end
end
