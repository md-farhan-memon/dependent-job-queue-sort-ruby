require 'set'

# A simple class for directed adjacency graph where an edge u, v
# means that u has higher priority than v OR u comes before v OR
# v is dependent on u
# Ref: https://github.com/monora/rgl
class Graph
  attr_accessor :vertices_hash

  def initialize
    @vertices_hash = {}
  end

  # Add a directed edge to the graph
  def add_edge(u, v)
    add_vertex(u)
    add_vertex(v)
    @vertices_hash[u].add(v)
  end

  private

  # Add vertex with an empty set if it is uninitialized
  def add_vertex(v)
    @vertices_hash[v] ||= Set.new
  end
end
