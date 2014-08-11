require_relative 'parameter_helpers'

module Lab42
  module Tmux
    class Session
      module Commands
        def new_window name
          @win_number += 1
          commands << %W{ new-window #{session_address} -n #{name} }
        end

        def send_keys *keys
          commands << %W{ send-keys #{window_address} #{keys.map(&:inspect).join(' ')} C-m }
        end
      end # module Commands
      include Commands
    end # class Session
  end # module Tmux
end # module Lab42
