class Voronoi
  attr_reader :grid, :points

  def initialize(points)
    @points = points
    x_coords = @points.map { |i| i[0] }
    y_coords = @points.map { |i| i[1] }
    @grid = Array.new(y_coords.max + 1) { Array.new (x_coords.max + 1) { '.' } }
    fill
    find_bounding_rectangle
    make_blacklist
  end

  def find_bounding_rectangle
    # any cell touching the rectangle enclosing all points will extend beyond
    # it infinitely, so defining that rectangle is important
    @max_x = 0
    @max_y = 0
    @min_x = Float::INFINITY
    @min_y = Float::INFINITY
    @points.each do |i|
      @max_x = [@max_x, i[0]].max
      @max_y = [@max_y, i[1]].max
      @min_x = [@min_x, i[0]].min
      @min_y = [@min_y, i[1]].min
    end

  end

  def fill
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        distances = []
        @points.each.with_index do |o, i|
          distances[i] = (o[0] - col).abs + (o[1] - row).abs
        end
        shortest = distances.min
        distances.count(shortest) > 1 ? @grid[row][col] = '-' : @grid[row][col] = distances.index(shortest)
      end
    end
  end

  def make_blacklist
    # any cell that touches the bounding rectangle is infinite, so don't bother
    # checking its area
    @blacklist = []
    # for each row push the values in the @min_x and @max_y columns
    @grid.each { |row| @blacklist.push(row[@min_x]); @blacklist.push(row[@max_x]) }
    # push every value on rows @min_y and @max_y
    @grid[@min_y].each { |i| @blacklist.push(i) }
    @grid[@max_y].each { |i| @blacklist.push(i) }
    @blacklist.uniq!
  end

  def get_largest_area
    largest_area = 0
    @points.each_index do |i|
      unless @blacklist.index(i)
        this_area = 0
        @grid.each { |row| this_area += row.count(i) }
        largest_area = [largest_area, this_area].max
      end
    end
    largest_area
  end
end

points = File.readlines('./input', :chomp => true).map do |i|
  tmp = i.split(',')
  [tmp[0].to_i, tmp[1].to_i]
end

prob = Voronoi.new(points)
puts prob.get_largest_area
