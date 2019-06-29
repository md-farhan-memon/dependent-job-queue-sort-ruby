require 'bundler/setup'
require 'pty'
require 'timeout'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def run_command(pty, command)
  stdout, stdin, _pid = pty
  stdin.puts command
  sleep(0.3)
  stdout.readline
end

def fetch_stdout(pty)
  stdout, _stdin, _pid = pty
  res = []
  loop do
    begin
      Timeout.timeout(0.5) { res << stdout.readline }
    rescue EOFError, Errno::EIO, Timeout::Error
      break
    end
  end

  res.join('').gsub(/\r/,'')
end
