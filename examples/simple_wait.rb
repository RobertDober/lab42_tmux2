
require_relative '../lib/lab42/tmux/auto_import'

dry_run!

# Use default config
#

# home_dir '.'
# session_name from par
#

new_session 'simple' do
  wait_for 'hit' do
    send_keys 'echo hello'
  end
end
