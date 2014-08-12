require_relative 'parameter_helpers'

module Lab42
  module Tmux
    class Session
      module Commands
        def new_window name
          @win_number += 1
          commands << %W{ new-window #{session_address} -n #{name} }
          # TODO: Include after_new_window hoox
        end

        def send_keys *keys
          # TODO: determine target of the << operation (if in hook we need something more complicated here)
          commands << %W{ send-keys #{window_address} #{keys.map(&:inspect).join(' ')} C-m }
        end
      end # module Commands
      include Commands
    end # class Session
  end # module Tmux
end # module Lab42
