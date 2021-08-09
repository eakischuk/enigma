class Enigma
  def encrypt(message, key = ["0", "1", "2", "3", "4", "5", "6", "7", "8","9"].sample(5).join, date = (Date.today.to_s.delete_prefix("20").split("-")).reverse.join)
      cipher = Cipher.new(message, key, date)
      cipher.encrypted_message
  end

  def decrypt(cyphertext, key, date = (Date.today.to_s.delete_prefix("20").split("-")).reverse.join)
    cipher = Cipher.new(cyphertext, key, date)
    cipher.decrypted_message
  end
end
