require 'pry'
binding.pry
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

def one_off?(x, y)
  different_chars = 0
  (0..x.length - 1).each { |i| different_chars += 1 if x[i] != y[i] }
  different_chars == 1 ? true : false
end

(0..box_ids.length - 2).each do |i|
  (i + 1..box_ids.length - 1).each do |j|
    if one_off?(box_ids[i], box_ids[j])
      (0..box_ids[i].length - 1).each do |k|
        if box_ids[i][k] != box_ids[j][k]
          puts "common characters are #{box_ids[i][0,k] + box_ids[i][k+1..-1]}"
          exit
        end
      end
    end
  end

end
