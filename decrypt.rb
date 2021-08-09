require './lib/enigma'

enigma = Enigma.new
cyphertext = File.read(ARGV[0])
new_file = File.open(ARGV[1], "w")
info = enigma.decrypt(cyphertext, ARGV[2].to_s, ARGV[3].to_s)
new_file.write(info[:decryption])
new_file.close
p "Created #{new_file.path}, with the key #{info[:key]} and date #{info[:date]}"
