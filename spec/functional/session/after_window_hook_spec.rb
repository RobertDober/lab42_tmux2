require 'spec_helper'

describe T::Session do
  context 'run' do
    context 'after_new_window' do 
      let( :session_name ){ 'after-new-window' }
      let( :session ){ described_class.new session_name }
      
      before do
        stub_tmux_query session_name, false # as if the session does not exist
      end
      
      it 'inserts the hook command in the right places' do
        session.define ->{
          after_new_window do
            send_keys "echo hook"
          end
          new_window "second"
        }
        session.register_commands

         expect(session.commands.map(&join(' '))).to eq [
          "source-file #{ENV["HOME"]}/.tmux.conf",
          "new-session -d -s #{session_name} -n sh",
          "set-window-option -g automatic-rename off",
          "send-keys -t #{session_name}:0 \"echo hook\" C-m",
          "new-window -t #{session_name} -n second",
          "send-keys -t #{session_name}:1 \"echo hook\" C-m",
          "attach-session -t #{session_name}" 
        ]
      end
    end # context 'after_new_window'
  end # context 'run'
end # describe T::Session

