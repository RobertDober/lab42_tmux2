require_relative 'parameter_helpers'

module Lab42
  module Tmux
    class Session
      module Commands
        def new_window name
          @win_number += 1
          commands << %W{ new-window #{session_address} -n #{name} }
        end
      end # module Commands
      include Commands
    end # class Session
  end # module Tmux
end # module Lab42
