lines = File.readlines('./input', :chomp=> true)
freq = 0
freq_values = []
lines.each do |i|
  freq += i.to_i
  freq_values.push(freq)
end

puts "part 1 calibrated frequency is #{freq}"

lines.cycle do |i|
  freq += i.to_i
  if freq_values.index(freq)
    puts "part 2 calibrated frequency is #{freq}"
    break
  else
    freq_values.push(freq)
  end
end
