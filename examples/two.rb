
require_relative '../lib/lab42/tmux/auto_import'

include T

# Use default config
#

# home_dir '.'
# session_name from par
#

new_session 'two' do
  new_window 'vi'
end