
require_relative '../lib/lab42/tmux/auto_import'

dry_run!

new_session 'simpleWait' do
  wait_for 'hit' do
    send_keys 'echo hello'
  end
end
