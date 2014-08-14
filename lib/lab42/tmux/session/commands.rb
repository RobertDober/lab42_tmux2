require_relative 'parameter_helpers'

module Lab42
  module Tmux
    class Session
      module Commands
        def new_window window_name, &block
          @window_number += 1
          command 'new-window', '-t', session_name, '-n', window_name
          instance_exec( &@after_new_window_hook ) if @after_new_window_hook
          instance_exec( &block ) if block
        end

        def send_keys *keys
          # TODO: determine target of the << operation (if in hook we need something more complicated here)
          command( 'send-keys', '-t', [session_name, window_number].join(':'), *keys.map(&:inspect), 'C-m' )
        end

        def wait_for text_or_rgx, alternate_pane_addr=nil, &blk
          pane_addr = alternate_pane_addr || window_address
          commands << -> do
            loop do
              text = capture_pane pane_addr
              return instance_exec( &blk ) if text_or_rgx === text
              # TODO: Get sleep time from config
              sleep 0.1
            end
          end
        end

        private

      end # module Commands
      include Commands
    end # class Session
  end # module Tmux
end # module Lab42
