#!/usr/bin/env ruby

require_relative 'lib/job_queu.rb'

# Initialize the empty job queu
@job_queu = JobQueu.new

# Exit the script on recieving 'exit' command
until (command = STDIN.gets.chomp).eql?('exit')
  # Prioritize the job queu if all job structures are entered - empty input
  if command.empty?
    begin
      puts @job_queu.prioritize.join(', ')
    rescue JobQueu::CircularDependencyError => e
      puts "Error: #{e.message}"
      @job_queu.reset!
    end
    @job_queu.reset!
  # Else add the structure to the queu
  else
    begin
      @job_queu.add(command)
    rescue JobQueu::SelfDependentJobError => e
      puts "Error: #{e.message}"
      @job_queu.reset!
    end
  end
end
