require_relative 'tmux/config'
require_relative 'tmux/interface'
require_relative 'tmux/session'

module Lab42
  module Tmux

    def new_session session_name=nil, &block
      raise ArgumentError, 'No block provided' unless block
      session = Session.new session_name || Config.session_name
      session.define block if block
      session.run!
    end

  end # module Tmux
end # module Lab42
