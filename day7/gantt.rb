class Task
  attr_reader :name, :dependencies, :requirements

  def initialize(name)
    @name = name
    @dependencies = []
    @requirements = []
  end

  def add_dependency(task)
    @dependencies.push(task)
  end

  def add_requirement(task)
    @requirements.push(task)
  end
end

tasklist = File.readlines('./testcase', :chomp => true)

taskhash = {}
tasklist.each do |i|
  #this will re-instantiate a bunch of stuff but idc
  words = i.split(' ')
  prereq = words[1]
  dependent = words[7]
  taskhash[prereq] = Task.new(prereq) unless taskhash[prereq] != nil
  taskhash[dependent] = Task.new(dependent) unless taskhash[dependent] != nil
  taskhash[prereq].add_dependency(taskhash[dependent])
  taskhash[dependent].add_requirement(taskhash[prereq])
end
