require 'spec_helper'

describe T::Session do
  context 'run' do
    context 'with send keys' do
      let( :session_name ){ 'my-sess' }
      let( :session ){ described_class.new session_name }
      
      it 'inovkes capture window until it contains the text' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:query,   'capture-pane', '-t', [session_name, 0].join(':'), '-p', {returns: ''}], 
          [:query,   'capture-pane', '-t', [session_name, 0].join(':'), '-p', {returns: "this\nand some_text too\nand more" }], 
          [:command, 'send-keys','-t', [session_name, 0].join(':'), 'echo hello'.inspect, 'C-m'],
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
          wait_for 'some_text' do
            send_keys 'echo hello'
          end
        end
      end

      it 'inovkes capture window until it times out and does not run the block', :slow do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:query,   'capture-pane', '-t', [session_name, 0].join(':'), '-p', {returns: ''}], 
          [:query,   'capture-pane', '-t', [session_name, 0].join(':'), '-p', {returns: ''}], 
          [:query,   'capture-pane', '-t', [session_name, 0].join(':'), '-p', {returns: ''}], 
          [:query,   'capture-pane', '-t', [session_name, 0].join(':'), '-p', {returns: "this\nand some_text too\nand more" }], 
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
          wait_for 'some_more_text' do
            send_keys 'echo hello'
          end
        end
      end

      it 'can change timeout and wait values' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:query,   'capture-pane', '-t', [session_name, 0].join(':'), '-p', {returns: ''}], 
          [:query,   'capture-pane', '-t', [session_name, 0].join(':'), '-p', {returns: ''}], 
          [:query,   'capture-pane', '-t', [session_name, 0].join(':'), '-p', {returns: ''}], 
          [:command, 'attach-session', '-t', session_name]
        )
        session.configuration.wait_interval 0.1
        session.configuration.wait_timeout 0.3
        session.run do
          wait_for 'some_more_text' do
            send_keys 'echo hello'
          end
        end
        
      end
    end # context 'with session'
  end # context 'run'
end # describe T::Session
