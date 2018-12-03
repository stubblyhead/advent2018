box_ids = File.readlines('./input', :chomp => true)

two_counts = 0
three_counts = 0

box_ids.each do |i|
  letter_counts = Hash.new(0)
  i.chars.each { |j| letter_counts[j] += 1}
  two_counts += 1 if letter_counts.value?(2)
  three_counts += 1 if letter_counts.value?(3)
end

puts "part one checksum is #{two_counts * three_counts}"
