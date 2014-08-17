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

        # TODO: Refactor
        def wait_for text_or_rgx, alternate_pane_addr=nil, &blk
          require 'timeout'
          pane_addr = alternate_pane_addr || window_address
          text_or_rgx = %r{#{text_or_rgx}} unless Regexp === text_or_rgx
          conditional_sleep configuration.pre_wait_interval
          Timeout.timeout configuration.wait_timeout do
            loop do
              text = capture_pane pane_addr
              if text_or_rgx === text
                conditional_sleep configuration.post_wait_interval
                return instance_exec( &blk )
              end
              # TODO: Get sleep time from config
              sleep configuration.wait_interval
            end
          end
        rescue Timeout::Error 
        end

        private 
        def capture_pane pane_addr
          query( 'capture-pane', *(pane_addr.split), '-p' ) 
        end
        def conditional_sleep sleepy_or_falsy
          sleep sleepy_or_falsy if sleepy_or_falsy
        end

      end # module Commands
      include Commands
    end # class Session
  end # module Tmux
end # module Lab42
