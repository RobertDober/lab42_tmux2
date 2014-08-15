require 'spec_helper'

describe T::Session, :obsolete do
  context 'run' do 
    context 'with configured session' do
      let( :session_name ){ 'my-sess' }
      let!( :session ){ described_class.new session_name }
      
      before do
        stub_tmux_query session_name, false # as if the session does not exist
        session.config{ |c| c.window_automatic_rename true }
      end

      it 'an empty session without automatic rename off' do
        session.register_commands

        expect( session.commands.map(&join(' ')) ).to eq [
          "source-file #{ENV["HOME"]}/.tmux.conf",
          "new-session -d -s #{session_name} -n sh",
          "attach-session -t #{session_name}" 
        ]
      end

      it 'and a new_window can be opened' do
        session.define ->{
          new_window 'vi'
        }
        session.register_commands
        expect( session.commands.map(&join( ' ' )) ).to eq [
          "source-file #{ENV["HOME"]}/.tmux.conf",
          "new-session -d -s #{session_name} -n sh",
          # " set-window-option -g automatic-rename off",
          "new-window -t #{session_name} -n vi",
          "attach-session -t #{session_name}" 
        ]
      end

      it 'can also send some keys' do
        session.define ->{
          new_window 'vi'
          send_keys 'vi .'
          send_keys ':colorscheme morning'
        }
        session.register_commands
        expect( session.commands.map(&join( ' ' )) ).to eq [
          "source-file #{ENV["HOME"]}/.tmux.conf",
          "new-session -d -s #{session_name} -n sh",
          # " set-window-option -g automatic-rename off",
          "new-window -t #{session_name} -n vi",
          "send-keys -t #{session_name}:1 \"vi .\" C-m",
          "send-keys -t #{session_name}:1 \":colorscheme morning\" C-m",
          "attach-session -t #{session_name}" 
        ]
      end
    end # context 'with session'
  end # context 'run'
end # describe T::Session
