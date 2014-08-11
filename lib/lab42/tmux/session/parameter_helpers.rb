module Lab42
  module Tmux
    class Session
      module ParameterHelpers
        def session_address
          "-t #{name}"
        end
        def window_address
          "-t #{name}:#{win_number}"
        end
      end # module ParameterHelpers
      include ParameterHelpers
    end # class Session
  end # module Tmux
end # module Lab42
