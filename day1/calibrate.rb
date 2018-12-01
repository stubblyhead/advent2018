lines = File.readlines('./testcase', :chomp=> true)
freq = 0
lines.each { |i| freq += i.to_i }

puts "calibrated frequency is #{freq}"
