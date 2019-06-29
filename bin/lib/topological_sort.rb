require 'set'

# A topological sort of a directed graph is a linear ordering of its vertices such that
# for every directed edge u -> v, u comes before v in the ordering.
# Ref: https://en.wikipedia.org/wiki/Topological_sorting
class TopologicalSort
  attr_accessor :list, :vertices_with_depth, :vertices_hash, :sorted_list

  # Using kahn's algorithm for sorting, which works
  # by choosing vertices in the same order as the eventual topological sort.
  # Ref: https://en.wikipedia.org/wiki/Topological_sorting#Kahn's_algorithm
  def initialize(vertices_hash)
    @list = []
    @sorted_list = []
    @vertices_hash = vertices_hash
    @vertices_with_depth = Hash.new(0)

    # Creating a hash with dependency count
    @vertices_hash.each_key do |vertex|
      @vertices_with_depth[vertex] = 0 unless @vertices_with_depth.key?(vertex)
      @vertices_hash[vertex].each { |dependency| @vertices_with_depth[dependency] += 1 }
    end

    # Creating a list with zero dependency count
    @vertices_with_depth.each { |vertex, depth| @list.push(vertex) if depth.zero? }
  end

  # Returns the sorted list
  def perform
    kahn_sorting if @sorted_list.empty?

    @sorted_list
  end

  private

  def kahn_sorting
    @sorted_list << least_depth_vertex until @list.empty?
  end

  def least_depth_vertex
    vertex = @list.pop
    reset_depth(vertex)
    vertex
  end

  def reset_depth(vertex)
    @vertices_hash[vertex].each do |dependency|
      @vertices_with_depth[dependency] -= 1
      @list.push(dependency) if @vertices_with_depth[dependency].zero?
    end
  end
end
