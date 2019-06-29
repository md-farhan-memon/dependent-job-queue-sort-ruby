require 'spec_helper'

RSpec.describe 'Job Queu', unit: true do
  let(:job_queu) { JobQueu.new }

  after(:each) do
    job_queu.reset!
  end

  context 'On initialization' do
    it 'creates an instance of Graph' do
      expect(job_queu.graph).to be_a(Graph)
    end
    it 'creates an empty sorted list' do
      expect(job_queu.sorted_list).to eql([])
    end
  end

  context 'With dependent edge' do
    it 'adds an edge in the graph with 2 vertices' do
      expect(job_queu.graph.vertices_hash.count).to eql(0)
      job_queu.add('a => b')
      expect(job_queu.graph.vertices_hash.count).to eql(2)
    end
  end

  context 'With independent edge' do
    it 'creates a set of independent vertices' do
      expect(job_queu.graph.vertices_hash.count).to eql(0)
      job_queu.add('a =>')
      job_queu.add('b =>')
      expect(job_queu.graph.vertices_hash.count).to eql(3)
    end
  end

  context 'with valid directed graph present in queu' do
    it 'can reset the graph' do
      job_queu.add('a => b')
      job_queu.add('b =>')
      job_queu.prioritize
      job_queu.reset!
      expect(job_queu.graph.vertices_hash).to eql({})
      expect(job_queu.sorted_list).to eql([])
    end

    it 'can sort the graph' do
      job_queu.add('a =>')
      job_queu.add('b => c')
      job_queu.add('c =>')
      expect(job_queu.prioritize).to eql(%w[c b a])
    end
  end

  context 'with invalid directed graph present in queu' do
    it 'can detect self dependent jobs' do
      expect { job_queu.add('c => c') }.to raise_error(JobQueu::SelfDependentJobError)
    end

    it 'can detect cyclic graphs' do
      job_queu.add('a =>')
      job_queu.add('b => c')
      job_queu.add('c => f')
      job_queu.add('d => a')
      job_queu.add('e =>')
      job_queu.add('f => b')
      expect { job_queu.prioritize }.to raise_error(JobQueu::CircularDependencyError)
    end
  end
end
