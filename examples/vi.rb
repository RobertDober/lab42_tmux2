
require_relative '../lib/lab42/tmux/auto_import'

# Use default config
#

# home_dir '.'
# session_name from par
#

new_session 'two' do
  send_keys 'date'
  new_window 'vi'
  send_keys 'vi .'
  send_keys ':colorschem morning'
end
