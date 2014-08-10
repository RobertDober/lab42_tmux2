module Lab42
  module Tmux
    module Interface
      def command *args
        %x{ tmux #{ args.join ' ' } }
      end
    end # module Interface
  end # module Tmux
end # module Lab42
