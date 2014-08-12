module Lab42
  module Tmux
    # Dry Run Interface
    module Interface extend self
      def command *args
        puts args.join( ' ' )
      end
      def query *args
        puts args.join( ' ' )
        return args.first != 'has-session'
      end
    end # module Interface
  end # module Tmux
end # module Lab42
