module Lab42
  module Tmux
    module Config extend self
      def init_singleton
      end
      def session_name *args
        return @session_name if args.empty?
        @session_name = args.first
      end
    end # module Config
  end # module Tmux
end # module Lab42
