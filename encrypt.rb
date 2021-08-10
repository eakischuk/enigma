require './spec/spec_helper'

enigma = Enigma.new
message = File.read(ARGV[0])
new_file = File.open(ARGV[1], "w")
info = enigma.encrypt(message)
new_file.write(info[:encryption])
new_file.close
p "Created #{new_file.path}, with the key #{info[:key]} and date #{info[:date]}"
