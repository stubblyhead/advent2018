class Guard
  attr_reader :asleep_time, :minutes

  def initialize
    @asleep_time = 0
    @minutes = Array.new(60) { 0 }
  end

  def count_sleep(asleep, awake)
    (asleep..awake-1).each do |i|
      @minutes[i] += 1
      @asleep_time += 1
    end
    most_sleep
  end

  def most_sleep
    highest_freq = @minutes.max
    return @minutes.index(highest_freq)
  end
end
