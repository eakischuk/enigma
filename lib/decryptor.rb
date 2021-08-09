class Decryptor
  include Cipherable
  attr_reader :range, :message, :key, :date
  def initialize(message, key, date)
    @message = message
    @key = ShiftKey.new(key)
    @date = ShiftOffset.new(date)
    @range = ("a".."z").to_a << " "
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

  def decrypted_hash
    decrypted = Hash.new {|hash, key| hash[key] = []}
    normalized_hash.each_pair do |group, letters|
      decrypted[group] = unshift(group, letters)
    end
    decrypted
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
    info = {decryption: string, key: @key.shift_key, date: @offset.date}
  end
end
