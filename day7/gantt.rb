# require 'pry'
# binding.pry

class Task
  attr_reader :name, :dependencies, :requirements, :is_complete

  def initialize(name)
    @name = name
    @dependencies = []
    @requirements = []
    @is_complete = false
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

  def complete
    @is_complete = true
    @dependencies.each { |i| i.remove_requirement(self) }
  end

  def to_s
    @name
  end

  def <=>(other)
    self.name <=> other.name
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
task_order = ''
while true
  task_hash.each_value { |i| available_tasks.push(i) if i.requirements == [] and i.is_complete == false }
  break if available_tasks.length == 0
  available_tasks.sort!.uniq!
  task_order += available_tasks[0].name
  task_hash[available_tasks[0].name].complete
  available_tasks.shift
end
puts task_order
