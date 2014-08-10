require_relative 'errors'
require_relative 'session/commands'

module Lab42
  module Tmux
    class Session
      attr_reader :commands, :name, :win_number

      def define block
        @definition_block = block
      end

      def run!
        run
        run_registered_commands
      end

      def run
        create_session_and_windows unless running?
        instance_exec( &@definition_block ) if @definition_block
        attach
      end

      private
      def initialize sess_name
        @name = sess_name
        @win_number = 0
        @commands = []

        self.class.instance self
      end

      def attach
        add_command 'attach-session', '-t', name
      end

      def add_command *args
        commands << args
      end
      def create_session_and_windows
        add_command 'source-file', File.join( ENV["HOME"], '.tmux.conf' )
        add_command 'new-session', '-d', '-s', name, '-n', 'sh'
      end

      def running?
        Interface.query 'has-session', '-t', name
      end

      def run_command command
        case command
        when String
          Lab42::Tmux::Interface.command command
        when Array
          Lab42::Tmux::Interface.command( *command )
        else
          instance_exec( &command )
        end
      end

      def run_registered_commands
        commands.each do | command |
          run_command command
        end
      end

      class << self 
        def instance an_instance=nil
          return @instance unless an_instance
          @instance = an_instance
        end

        def run
          raise Lab42::Tmux::NoSessionDefined, "you need to define a session with `new_session` in your script" unless instance
          instance.run
        end
      end # class <<
    end # class Session
  end # module Tmux
end # module Lab42
