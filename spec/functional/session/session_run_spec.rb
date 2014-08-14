require 'spec_helper'

describe T::Session do 
  context 'run' do 
    context 'with session', :wip do
      let( :session_name ){ 'my-sess' }
      let( :session ){ described_class.new session_name }
      
      it 'an empty session opens only one window' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
        end
      end

      it 'and a new_window can be opened' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:command, 'new-window', '-t', session_name, '-n', 'vi'],
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
          new_window 'vi'
        end
      end

      it 'can also send some keys' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:command, 'new-window', '-t', session_name, '-n', 'vi'],
          [:command, 'send-keys', '-t', [session_name,1].join(':'), 'vi .'.inspect, 'C-m'],
          [:command, 'send-keys', '-t', [session_name,1].join(':'), ':colorscheme morning'.inspect, 'C-m'],
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
          new_window 'vi' do
            send_keys 'vi .'
            send_keys ':colorscheme morning'
          end
        end 
      end
    end # context 'with session'
  end # context 'run'
end # describe T::Session
