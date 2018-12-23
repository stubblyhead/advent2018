require 'pry'
binding.pry

class Voronoi
  attr_reader :grid, :points

  def initialize(points)
    @points = points
    x_coords = @points.map { |i| i[0] }
    y_coords = @points.map { |i| i[1] }
    @grid = Array.new(y_coords.max + 1) { Array.new (x_coords.max + 1) { '.' } }
    @points.each.with_index do |o, i|
      @grid[o[1]][o[0]] = (i+65).chr
    end
  end
end

points = File.readlines('./testcase', :chomp => true).map do |i|
  tmp = i.split(',')
  [tmp[0].to_i, tmp[1].to_i]
end

prob = Voronoi.new(points)
true
