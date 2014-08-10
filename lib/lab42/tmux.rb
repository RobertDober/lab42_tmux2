require_relative 'tmux/config'
require_relative 'tmux/interface'
require_relative 'tmux/session'

module Lab42
  module Tmux

    def new_session session_name=nil, &block
      raise ArgumentError, 'No block provided' unless block
      session = Session.new session || Config.session_name
      session.run block
    end
    
  end # module Tmux
end # module Lab42

at_exit do
  Lab42::Tmux::Session.run
end
