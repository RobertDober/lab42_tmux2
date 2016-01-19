require_relative 'tmux/config'
require_relative 'tmux/interface'
require_relative 'tmux/session'
require_relative 'tmux/plugins'

module Lab42
  module Tmux

    def config &block
      $config = Config.new
      $config.instance_exec( &block )
    end

    def new_session session_name=nil, &block
      raise ArgumentError, 'No block provided' unless block
      session = Session.new( session_name || File.basename( ENV["PWD"] ) )
      session.run &block
    end

    def dry_run!
      require_relative 'tmux/dry_run'
    end
  end # module Tmux
end # module Lab42
