module Lab42
  module Tmux
    module Interface extend self
      def command *args
        %x{ tmux #{ args.join ' ' } }
      end
      def query *args
        system "tmux #{ args.join ' ' }"
      end
    end # module Interface
  end # module Tmux
end # module Lab42
