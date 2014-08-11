require_relative '../tmux'

T = Tmux = Lab42::Tmux

at_exit do
  Lab42::Tmux::Session.run
end
