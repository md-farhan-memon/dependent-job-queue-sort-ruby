require_relative 'graph.rb'
require_relative 'topological_sort.rb'

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

    raise SelfDependentJobError, "Jobs can't depend on themselves." if dependent_jobs?(array)

    @graph.add_edge(*array)
  end

  # Resets the queu by initializing an empty graph
  def reset!
    @graph = Graph.new
    @sorted_list = []
  end

  def prioritize
    @sorted_list = topological_sort if @sorted_list.empty?

    raise CircularDependencyError, "Jobs can't have circular dependency." unless acyclic?

    @sorted_list.compact
  end

  private

  def topological_sort
    t_sort = TopologicalSort.new(@graph.vertices_hash)
    t_sort.perform
  end

  def dependent_jobs?(array)
    array[0].eql?(array[1])
  end

  def acyclic?
    @sorted_list.count.eql?(graph.vertices.count)
  end
end
