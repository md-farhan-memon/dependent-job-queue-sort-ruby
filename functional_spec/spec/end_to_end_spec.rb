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
        "c, b, a\n",
        "c, b, a\n",
        "f, c, b, e, a, d\n",
        "Error: Jobs can't depend on themselves.\n\n",
        "Error: Jobs can't have circular dependency.\n"
      ]
    end

    it 'interactive shell input' do
      project_bin_dir = File.join(File.dirname(File.expand_path(__FILE__)), '..', '..', 'bin')
      pty = PTY.spawn("ruby #{project_bin_dir}/execute.rb")
      commands.each_with_index do |cmd, index|
        puts cmd
        run_command(pty, cmd)
        expect(fetch_stdout(pty)).to end_with(expected[index])
      end
    end
  end
end
