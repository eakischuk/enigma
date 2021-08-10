class Encryptor
  include Cipherable
  attr_reader :range, :message, :key, :date
  def initialize(message, key, date)
    @message = message
    @key = ShiftKey.new(key)
    @date = ShiftOffset.new(date)
    @range = ("a".."z").to_a << " "
  end

  def shift(group, letter_array)
    letter_array.map do |letter|
      if @range.include?(letter)
        new_index = (letter_index(@range, letter) + shifts(@range, @key, @date)[group]) % 27
        letter = @range[new_index]
      else
        letter
      end
    end
  end

  def encrypted_hash
    encrypted = Hash.new {|hash, key| hash[key] = []}
    normalized_hash(@message).each_pair do |group, letters|
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
      arrays_to_string(string, arr1, arr2, arr3, arr4)
    end
    info = {encryption: string, key: @key.shift_key, date: @date.date}
  end
end
