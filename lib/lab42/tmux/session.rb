require_relative 'errors'

module Lab42
  module Tmux
    class Session
      attr_reader :name

      private
      def initialize sess_name
        @name = sess_name
        self.class.instance self
      end

      class << self 
        def instance an_instance=nil
          return @instance unless an_instance
          # raise RuntimeError, "there can only be on" if an_instance && @instance
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
