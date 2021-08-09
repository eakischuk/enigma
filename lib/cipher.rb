require 'shift_key'
require 'shift_offset'

class Cipher
  attr_reader :key, :offset, :range

  def initialize(message, key, date)
    @message = message
    @key = ShiftKey.new(key)
    @offset = ShiftOffset.new(date)
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

  def letter_index(letter)
    @range.find_index(letter)
  end

  def shift(group, letter_array)
    letter_array.map do |letter|
      if @range.include?(letter)
        letter = @range[(letter_index(letter) + shifts[group]) % 27]
      else
        letter
      end
    end
  end

  def unshift(group, letter_array)
    letter_array.map do |letter|
      if @range.include?(letter)
        letter = @range[(letter_index(letter) - shifts[group]) % 27]
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

  def decrypted_hash
    decrypted = Hash.new {|hash, key| hash[key] = []}
    normalized_hash.each_pair do |group, letters|
      decrypted[group] = unshift(group, letters)
    end
    decrypted
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

  def encrypted_message
    string = ""
    arr1 = encrypted_hash["A"]
    arr2 = encrypted_hash["B"]
    arr3 = encrypted_hash["C"]
    arr4 = encrypted_hash["D"]
    until arr1.empty? && arr2.empty? && arr3.empty? && arr4.empty?
      arrays_to_string(string, arr1, arr2, arr3, arr4)
    end
    string
  end

  def decrypted_message
    string = ""
    arr1 = decrypted_hash["A"]
    arr2 = decrypted_hash["B"]
    arr3 = decrypted_hash["C"]
    arr4 = decrypted_hash["D"]
    until arr1.empty? && arr2.empty? && arr3.empty? && arr4.empty?
      arrays_to_string(string, arr1, arr2, arr3, arr4)
    end
    string
  end
end
