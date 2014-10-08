require 'spec_helper'

describe T::Session do
  context 'run' do 
    let( :project_dir ){ '/wherever' }
    let( :session_name ){ 'my-sess' }
    let( :session ){ described_class.new session_name }
    before do
      session.config do | c |
        c.project_home project_dir
      end
    end

    context 'project_home reset' do 
      let( :project_dir ){ nil }
      it 'is not sent for default window' do
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

      it 'and others neither' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:command, 'send-keys', '-t', [session_name,0].join(':'), 'echo hook'.inspect, 'C-m'],
          [:command, 'new-window', '-t', session_name, '-n', 'second'],
          [:command, 'send-keys', '-t', [session_name,1].join(':'), 'echo hook'.inspect, 'C-m'],
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
          after_new_window do
            send_keys "echo hook"
          end
          new_window "second"
        end
        
      end
      
    end # context 'project_home reset'

    context 'project_home changed' do 
      let( :project_dir ){ '/wherever' }

      it 'is sent for default window' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:command, 'send-keys', '-t', [session_name, 0].join(':'), "cd #{project_dir}".inspect, 'C-m'],
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
        end
      end

      it 'and others too' do
        set_interface_expectations(
          [:query, 'has-session', '-t', session_name],
          [:command, 'source-file', File.join(ENV["HOME"], '.tmux.conf')],
          [:command, 'new-session', '-d', '-s', session_name, '-n', 'sh'],
          [:command, 'set-window-option', '-g', 'automatic-rename', 'off'],
          [:command, 'send-keys', '-t', [session_name, 0].join(':'), "cd #{project_dir}".inspect, 'C-m'],
          [:command, 'send-keys', '-t', [session_name,0].join(':'), 'echo hook'.inspect, 'C-m'],
          [:command, 'new-window', '-t', session_name, '-n', 'second'],
          [:command, 'send-keys', '-t', [session_name, 1].join(':'), "cd #{project_dir}".inspect, 'C-m'],
          [:command, 'send-keys', '-t', [session_name,1].join(':'), 'echo hook'.inspect, 'C-m'],
          [:command, 'attach-session', '-t', session_name]
        )
        session.run do
          after_new_window do
            send_keys "echo hook"
          end
          new_window "second"
        end
        
      end
    end # context 'project_home'
  end # context 'run'
end
