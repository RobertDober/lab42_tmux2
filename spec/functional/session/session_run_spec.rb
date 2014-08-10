require 'spec_helper'

describe T::Session do 
  context 'run' do 
    it 'raises an error if there is no session' do
      expect( ->{
        described_class.run
      } ).to raise_error T::NoSessionDefined, 'you need to define a session with `new_session` in your script' 
    end
    context 'with session' do
      let( :session_name ){ 'my-sess' }
      let( :session ){ described_class.new session_name }
      
      before do
        stub_tmux_command
        stub_tmux_query session_name, false # as if the session does not exist
      end

      it 'an empty session opens only one window', :wip do
        session
        described_class.run
        expect( output ).to eq [
          "source-file #{ENV["HOME"]}/.tmux.conf",
          "new-session -d -s #{session_name} -n sh",
          # " set-window-option -g automatic-rename off",
          "attach-session -t #{session_name}" 
        ]
      end

      it 'and a new_window can be opened' do
        session.define ->{
          new_window 'vi'
        }
        described_class.run
        expect( output ).to eq [
          "source-file #{ENV["HOME"]}/.tmux.conf",
          "new-session -d -s #{session_name} -n sh",
          # " set-window-option -g automatic-rename off",
          "new-window -t #{session_name} -n vi",
          "attach-session -t #{session_name}" 
        ]
      end
    end # context 'with session'
  end # context 'run'
end # describe T::Session
