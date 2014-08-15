require 'spec_helper'

describe T::Session do
  context 'run' do
    context 'after_new_window' do 
      let( :session_name ){ 'after-new-window' }
      let( :session ){ described_class.new session_name }
      
      it 'inserts the hook command in the right places' do
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
    end # context 'after_new_window'
  end # context 'run'
end # describe T::Session

