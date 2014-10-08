require_relative '../lib/lab42/tmux/auto_import'

dry_run!

# Use default config
#

# home_dir '.'
# session_name from par
#
config do
  window_automatic_rename true
  project_home nil
end

new_session 'two-window-rename' do
  new_window 'vi'
end
