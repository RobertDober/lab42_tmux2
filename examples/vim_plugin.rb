require_relative '../lib/lab42/tmux/vim_plugin'

dry_run!

new_session 'vimPlugin' do
  vim_new_window 'vim', dir: 'there', colorscheme: 'blue', source: '.vim'
end
