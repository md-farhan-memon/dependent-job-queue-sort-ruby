require_relative 'graph.rb'

# Treating the job queu dependency as a Directed Adjacency Graph
# where the graph is directed from u -> v
# where u is the job to be performed before v
# because v is dependent on u
class JobQueu
  attr_accessor :graph, :sorted_list

  # Custom error classes
  class SelfDependentJobError < StandardError; end
  class CircularDependencyError < StandardError; end

  def initialize
    # Initializing instance of Graph class
    @graph = Graph.new
    @sorted_list = []
  end

  # add method takes job_structure as parameter
  # which is a string of form "u => v"
  def add(job_structure)
    # Splitting the string by the seperator "=>" and creating an array of jobs
    array = job_structure.split('=>').map do |job|
      job.strip!
      job unless job.empty?
    end

    # Handling independent jobs of type "a =>"
    array << nil if array.count.eql?(1)

    # reversing it because the input "a => b" means
    # a is dependent on b and so b is to be performed before a
    array.reverse!

    raise SelfDependentJobError, "Job '#{array.first}' depends on itself" if dependent_jobs?(array)

    @graph.add_edge(*array)
  end

  # Resets the queu by initializing an empty graph
  def reset!
    @graph = Graph.new
    @sorted_list = []
  end

  def prioritize
    # TODO: writing the sorting algorithm
  end

  private

  def dependent_jobs?(array)
    array[0].eql?(array[1])
  end
end
