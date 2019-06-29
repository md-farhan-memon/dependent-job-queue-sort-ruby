require 'spec_helper'

RSpec.describe 'Graph', unit: true do
  let(:graph) { Graph.new }

  after(:each) do
    graph.vertices_hash = {}
  end

  context 'On initialization' do
    it 'creates an empty hash for vertices' do
      expect(graph.vertices_hash).to eql({})
    end
  end

  context 'when adding edges' do
    it 'creates a key value pair where value is a Set' do
      graph.add_edge('a', 'b')
      expect(graph.vertices_hash['a']).to be_a(Set)
      expect(graph.vertices_hash['a']).to eql(Set.new(%w[b]))
    end

    it 'creates 2 vertices' do
      graph.add_edge('a', 'b')
      expect(graph.vertices_hash.count).to eql(2)
    end

    it 'returns all vertices in a graph' do
      graph.add_edge('a', 'b')
      graph.add_edge('c', 'd')
      expect(graph.vertices).to eql(%w[a b c d])
    end
  end
end
