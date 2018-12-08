class Guard
  attr_reader :asleep_time, :minutes, :sleepiest_minute

  def initialize
    @asleep_time = 0
    @minutes = Array.new(60) { 0 }
    @sleepiest_minute = 0
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
    @sleepiest_minute = @minutes.index(highest_freq)
  end

  def sleepiest_minute_times
    return @minutes[sleepiest_minute]
  end

end

lines = File.readlines('./input', :chomp => true)
lines.sort!
guards = {}

guard_number = nil
sleep_range = []
lines.each do |i|
  if i.match?(/#/) #A new guard has come on duty
    guard_number = i.split(' ')[-3][1..-1].to_i
    guards[guard_number] = Guard.new() unless guards.has_key?(guard_number)
  elsif i.match?(/falls asleep/)  #guard has fallen asleep, record the minute
    sleep_range[0] = i.split(' ')[1].split(':')[1].to_i
  elsif i.match?(/wakes up/)  #guard woke up, record the minute and calculate the sleep time
    sleep_range[1] = i.split(' ')[1].split(':')[1].to_i
    guards[guard_number].count_sleep(*sleep_range)
  end
end

longest_sleep = 0
greatest_freq = 0
sleepiest_guard = nil
sleepiest_minute = nil
most_often_guard = nil
most_often_minute = nil

guards.each do |id, guard|
  if guard.asleep_time > longest_sleep
    longest_sleep = guard.asleep_time
    sleepiest_guard = id
    sleepiest_minute = guard.sleepiest_minute
  end
  if guard.sleepiest_minute_times > greatest_freq
    greatest_freq = guard.sleepiest_minute_times
    most_often_guard = id
    most_often_minute = guard.sleepiest_minute
  end
end

puts "part 1: guard #{sleepiest_guard}, minute #{sleepiest_minute} ==> #{sleepiest_guard * sleepiest_minute}"
puts "part 2: guard #{most_often_guard}, minute #{most_often_minute} ==> #{most_often_guard * most_often_minute}"
