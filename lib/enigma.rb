require './spec/spec_helper'

class Enigma
  def encrypt(message, key = ["0", "1", "2", "3", "4", "5", "6", "7", "8","9"].sample(5).join, date = (Date.today.to_s.delete_prefix("20").split("-")).reverse.join)
    encryptor = Encryptor.new(message, key, date)
    encryptor.encrypted_message
  end

  def decrypt(cyphertext, key, date = (Date.today.to_s.delete_prefix("20").split("-")).reverse.join)
    decryptor = Decryptor.new(cyphertext, key, date)
    decryptor.decrypted_message
  end
end
