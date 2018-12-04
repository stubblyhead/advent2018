grid = Array.new(1050) { Array.new(1050) { 0 } }

claims = {} #it doesn't matter that multiple claims can start at the same point
            #because if they do they're automatically disqualified from being the
            #only non-overlapping claim
lines = File.readlines('./testcase', :chomp => true)
lines.each do |i|
  parts = i.split(/@|:/)
  corner = parts[1].split(',').map { |i| i.to_i }
  size = parts[2].split('x').map { |i| i.to_i }
  claims[corner] = [size, parts[0]]
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

claims.each do |corner, size|
  area_sum = 0
  goal = size[0][0] * size[0][1]
  (corner[0]..corner[0] + size[0][0] - 1).each do |i|
    (corner[1]..corner[1] + size[0][1] - 1).each do |j|
      area_sum += grid[i][j]
    end
  end
  if goal == area_sum
    puts "non-overlapping claim is #{size[1]}"
    exit
  end
end
