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

my_polymer = Polymer.new(File.read('./testcase').chomp)

my_polymer.react
puts my_polymer.chain, my_polymer.chain.length
