module Lab42
  module Tmux
    # Dry Run Interface
    module Interface extend self
      def command *args
        puts args.join( ' ' )
        return capture_pane( *args.drop( 1 ) ) if args.first == 'capture-pane'
      end
      def query *args
        puts args.join( ' ' )
        args.first != 'has-session'
      end

      private
      def cature_pane *args
        pane_addr = args[1]
        second_capture = (@panes ||= {})[pane-addr]
        if second_capture
          @panes[pane_addr] = false
          'hit'
        else
          @panes[pane_addr] = true
          'miss'
        end
      end
    end # module Interface
  end # module Tmux
end # module Lab42
