require 'spec_helper'

RSpec.describe T::Session do 
  context 'new_window' do 
    let( :session_name ){ 'spaces-in-win-name' }
    subject do
      described_class.new session_name
    end
    it "can have spaces in it's name" do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:command, 'send-keys', '-t', [session_name, 0].join(':'), "cd #{PROJECT_HOME}".inspect, 'C-m'],
          [:command, 'send-keys','-t', [session_name, 0].join(':'), 'echo hello'.inspect, 'C-m'],
          [:command, 'new-window','-t', session_name, '-n', "'win name'"],
          [:command, 'send-keys', '-t', [session_name, 1].join(':'), "cd #{PROJECT_HOME}".inspect, 'C-m'],
          [:command, 'attach-session', '-t', session_name]
        )
        subject.run do
          send_keys 'echo hello'
          new_window 'win name'
        end
      
    end
    
  end # context 'new_window'
end # describe T::Session
