grid = Array.new(1050) { Array.new(1050) { 0 } }

claims = {}

lines = File.readlines('./testcase', :chomp => true)
lines.each do |i|
  parts = i.split(/@|:/)
  top_corner = parts[1].split(',').map { |i| i.to_i }
  claims[top_corner] = parts[2].split('x').map { |i| i.to_i }
end

claims.each do |corner, size|
  (corner[0]..corner[0]+size[0]-1).each do |i|
    (corner[1]..corner[1]+size[1]-1).each do |j|
      grid[i][j] += 1
    end
  end
end

overlap_count = 0
grid.each do |i|
  i.each { |j| overlap_count += 1 if j > 1 }
end

puts "#{overlap_count} square inches overlap"
