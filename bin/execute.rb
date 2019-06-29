#!/usr/bin/env ruby

require_relative 'lib/job_queu.rb'

# Initialize the empty job queu
@job_queu = JobQueu.new

# Exit the script on recieving 'exit' command
until (command = STDIN.gets.chomp).eql?('exit')
  # Prioritize the job queu if all job structures are entered - empty input
  if command.empty?
    puts @job_queu.prioritize
    @job_queu.reset!
  # Else add the structure to the queu
  else
    @job_queu.add(command)
  end
end
