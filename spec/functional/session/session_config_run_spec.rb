require 'spec_helper'

describe T::Session do
  context 'run' do
    context 'with configured session' do
      let( :session_name ){ 'my-sess' }
      let( :session ){ described_class.new session_name }
      
      before do
        session.config{ |c| c.window_automatic_rename true }
      end

      it 'an empty session without automatic rename off' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'send-keys', '-t', [session_name, 0].join(':'), "cd #{PROJECT_HOME}".inspect, 'C-m'],
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
        end
      end

      it 'can also send some keys in a new window' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'send-keys', '-t', [session_name, 0].join(':'), "cd #{PROJECT_HOME}".inspect, 'C-m'],
          [:command, 'send-keys', '-t', [session_name, 0].join(':'), 'echo hello'.inspect, 'C-m'],
          [:command, 'new-window', '-t', session_name, '-n', 'vi'],
          [:command, 'send-keys', '-t', [session_name, 1].join(':'), "cd #{PROJECT_HOME}".inspect, 'C-m'],
          [:command, 'send-keys', '-t', [session_name, 1].join(':'), 'vi .'.inspect, 'C-m'],
          [:command, 'send-keys', '-t', [session_name, 1].join(':'), ':colorscheme morning'.inspect, 'C-m'],
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
          send_keys 'echo hello'
          new_window 'vi' do
            send_keys 'vi .'
            send_keys ':colorscheme morning'
          end
        end
      end
    end # context 'with session'
  end # context 'run'
end # describe T::Session
