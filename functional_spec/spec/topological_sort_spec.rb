require 'spec_helper'

RSpec.describe 'Topological Sort', unit: true do
  # Following job structure is used to construct vertices_hash
  #  a =>
  #  b => c
  #  c => f
  #  d => a
  #  e => b
  let(:acyclic_vertices_hash) do
    {
      nil => Set.new(%w[a f]),
      'a' => Set.new(['d']),
      'c' => Set.new(['b']),
      'b' => Set.new(['e']),
      'f' => Set.new(['c']),
      'd' => Set.new,
      'e' => Set.new
    }
  end

  # Following job structure is used to construct vertices_hash
  #  a =>
  #  b => c
  #  c => f
  #  d => a
  #  e =>
  #  f => b
  let(:cyclic_vertices_hash) do
    {
      nil => Set.new(%w[a e]),
      'a' => Set.new(['d']),
      'c' => Set.new(['b']),
      'b' => Set.new(['f']),
      'f' => Set.new(['c']),
      'd' => Set.new,
      'e' => Set.new
    }
  end
  context 'On initialisation' do
    before(:each) do
      @t_sort = TopologicalSort.new(acyclic_vertices_hash)
    end

    it 'creates as is copy of the hash' do
      expect(@t_sort.vertices_hash).to eql(acyclic_vertices_hash)
    end

    it 'calculates depth count for each vertex in a hash' do
      expect(@t_sort.vertices_with_depth).to be_a(Hash)
      expect(@t_sort.vertices_with_depth).to eql(nil => 0, 'a' => 1, 'f' => 1, 'd' => 1, 'c' => 1, 'b' => 1, 'e' => 1)
    end

    it 'creates an array list of vertices with 0 depth' do
      expect(@t_sort.list).to eql([nil])
    end
  end

  context 'After initialization' do
    it 'can sort the graph' do
      t_sort = TopologicalSort.new(acyclic_vertices_hash)
      expect(t_sort.perform).to eql([nil, 'f', 'c', 'b', 'e', 'a', 'd'])
    end

    it 'excludes the cycle while sorting the directed graph and resultant vertices are always less than actual vertices' do
      t_sort = TopologicalSort.new(cyclic_vertices_hash)
      sorted_list = t_sort.perform
      expect(sorted_list.count).to be < cyclic_vertices_hash.keys.count
      expect(sorted_list).to eql([nil, 'e', 'a', 'd'])
    end
  end
end
