class Task
  attr_reader :name, :dependencies, :requirements, :is_complete, :is_active, :duration

  def initialize(name)
    @name = name
    @dependencies = []
    @requirements = []
    @is_complete = false
    @is_active = false
    @duration = name.bytes[0] - 4
  end

  def add_dependency(task)
    @dependencies.push(task)
  end

  def add_requirement(task)
    @requirements.push(task)
  end

  def remove_requirement(task)
    @requirements.delete(task)
  end

  def work
    @is_active = true
    @duration -= 1
    complete if @duration == 0
  end

  def complete
    @is_complete = true
    @dependencies.each { |i| i.remove_requirement(self) }
  end

  def to_s
    @name
  end

  def inspect
    to_s
  end

  def <=>(other)
    self.name <=> other.name
  end
end

class Worker
  attr_reader :task

  def initialize
    @task = nil
  end

  def assign(task)
    @task = task
  end

  def work
    return if @task == nil
    @task.work
    if @task.is_complete
      @task = nil
      return :finished
    end
  end

  def is_busy?
    if @task
      return true
    else
      return false
    end
  end

end


tasklist = File.readlines('./input', :chomp => true)

task_hash = {}
tasklist.each do |i|
  words = i.split(' ')
  prereq = words[1]
  dependent = words[7]
  task_hash[prereq] = Task.new(prereq) unless task_hash[prereq] != nil
  task_hash[dependent] = Task.new(dependent) unless task_hash[dependent] != nil
  task_hash[prereq].add_dependency(task_hash[dependent])
  task_hash[dependent].add_requirement(task_hash[prereq])
end

available_tasks = []
workers = Array.new(5) { Worker.new }
duration = 0

while true
  if workers.select { |i| !i.is_busy? } # there's at least one available worker, so try to assign tasks
    task_hash.each_value { |i| available_tasks.push(i) if i.requirements == [] and i.is_complete == false and i.is_active == false } # push tasks onto queue if they have no no prerequisites and have not been completed and are not currently being worked
    available_tasks.sort!.uniq! # alphabetize and remove dupes
    workers.each do |i|
      i.assign(available_tasks.shift) unless i.is_busy?  # any available workers have been assigned any available tasks
    end
  end
  workers.each { |i| i.work } # everybody works
  duration += 1 # increment duration counter
  break if task_hash.values.select { |i| i.is_complete }.length == task_hash.values.length # exit loop if all tasks are complete
end

puts duration
