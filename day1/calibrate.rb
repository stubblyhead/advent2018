lines = File.readlines('./input', :chomp=> true)
freq = 0
lines.each { |i| freq += i.to_i }

puts "calibrated frequency is #{freq}"
