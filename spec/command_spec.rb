require 'spec_helper'

describe LXC::Command do
  describe '#initialize' do
    it 'does not have an output' do
      LXC::Command.new('foo').output.should be_nil
    end

    it 'does not have an exit status' do
      LXC::Command.new('foo').exit_status.should be_nil
    end
  end

  describe '#execute' do
    it 'captures command output' do
      cmd = LXC::Command.new(command_path('test_success'))
      cmd.execute

      cmd.output.should eq("STDOUT buffer\n")
    end

    it 'assignes command exit status' do
      cmd = LXC::Command.new(command_path('test_success'))
      cmd.execute

      cmd.exit_status.should eq(0)
    end
  end

  describe '#success?' do
    it 'returns true if command exit code is 0' do
      cmd = LXC::Command.new(command_path('test_success'))
      cmd.execute

      cmd.success?.should be_true
    end

    it 'returns false on non-zero exit codes' do
      cmd = LXC::Command.new(command_path('test_failure'))
      cmd.execute

      cmd.success?.should be_false

      cmd.exit_status = 1234
      cmd.success?.should be_false
    end
  end
end