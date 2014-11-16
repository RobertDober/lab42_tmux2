require 'spec_helper'

describe T::Session do
  context 'send_keys' do 
    let( :session_name ){ 'send-keys' }
    subject do
      described_class.new session_name
    end

    it 'can send keys to various windows' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:command, 'send-keys', '-t', [session_name, 0].join(':'), "cd #{PROJECT_HOME}".inspect, 'C-m'],
          [:command, 'send-keys','-t', [session_name, 0].join(':'), 'echo hello'.inspect, 'C-m'],
          [:command, 'new-window','-t', session_name, '-n', "'win'"],
          [:command, 'send-keys', '-t', [session_name, 1].join(':'), "cd #{PROJECT_HOME}".inspect, 'C-m'],
          [:command, 'send-keys','-t', [session_name, 1].join(':'), 'echo hello_again'.inspect, 'C-m'],
          [:command, 'attach-session', '-t', session_name]
        )
        subject.run do
          send_keys 'echo hello'
          new_window 'win' do
            send_keys 'echo hello_again'
          end
        end
      
    end
    it 'can send keys raw to various windows' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:command, 'send-keys', '-t', [session_name, 0].join(':'), "cd #{PROJECT_HOME}".inspect, 'C-m'],
          [:command, 'send-keys','-t', [session_name, 0].join(':'), 'echo hello'.inspect],
          [:command, 'new-window','-t', session_name, '-n', "'win'"],
          [:command, 'send-keys', '-t', [session_name, 1].join(':'), "cd #{PROJECT_HOME}".inspect, 'C-m'],
          [:command, 'send-keys','-t', [session_name, 1].join(':'), 'echo hello_again'.inspect],
          [:command, 'attach-session', '-t', session_name]
        )
        subject.run do
          send_keys_raw 'echo hello'
          new_window 'win' do
            send_keys_raw 'echo hello_again'
          end
        end
      
    end
  end # context 'send_keys'
end # describe T::Session
