require_relative '../lib/lab42/tmux/auto_import'

dry_run!

new_session 'after-window-hook' do
  after_new_window do
    send_keys "echo hook"
  end
  new_window 'vi' do
  end
end
