require 'open3'

module LXC
  class Command
    attr_accessor :command, :output, :exit_status

    def initialize(command, options={})
      @command = command.to_s.strip
      @options = options

      if @command.empty?
        raise ArgumentError, "Command required"
      end
    end

    def execute
      @output = ''

      Open3.popen3(command, command) do |stdin, stdout, stderr, wait_thr|
        @output << stdout.gets until stdout.eof?
        @exit_status = wait_thr.value.exitstatus
      end

      @output
    end

    def success?
      exit_status == 0
    end

    def failure?
      !success?
    end
  end
end