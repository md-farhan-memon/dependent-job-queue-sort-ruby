require 'spec_helper'

RSpec.describe 'End To End Suite' do
  describe 'full scenarios' do
    let(:commands) do
      [
        "\n",
        "a =>\n\n",
        "a =>\nb =>\nc =>\n\n",
        "a =>\nb => c\nc =>\n\n",
        "a =>\nb => c\nc => f\nd => a\ne => b\nf =>\n\n",
        "a =>\nb =>\nc => c\n\n",
        "a =>\nb => c\nc => f\nd => a\ne =>\nf => b\n\n"
      ]
    end

    let(:expected) do
      [
        "\n",
        "a\n",
        "a, b, c\n",
        "a, c, b\n",
        "a, d, f, c, b, e\n",
        "Error: Jobs can’t depend on themselves.\n",
        "Error: Jobs can’t have circular dependencies.\n"
      ]
    end

    it 'interactive shell input' do
      pty = PTY.spawn('ruby execute.rb')
      puts "\nTesting interactive shell input: "
      commands.each_with_index do |cmd, index|
        puts cmd
        run_command(pty, cmd)
        expect(fetch_stdout(pty)).to end_with(expected[index])
      end
    end
  end
end
