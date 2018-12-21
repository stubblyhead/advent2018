class Polymer
  attr_reader :chain

  def initialize(str)
    @chain = str
  end

  def react
    while true
      prev_chain = @chain
      (0..@chain.length-2).each do |i|
        if @chain[i] == @chain[i+1].swapcase
          @chain = @chain[0,i] + @chain[i+2..-1]
          break
        end
      end
      break if prev_chain.length == @chain.length
    end
  end

  def to_s
    @chain
  end
end

my_polymer = File.read('./input').chomp
lengths = {}
('a'..'z').each do |i|
  str = my_polymer.gsub(i,'').gsub(i.swapcase,'')
  this_polymer = Polymer.new(str)
  this_polymer.react
  lengths[i] = this_polymer.chain.length
end

puts lengths.values.min
