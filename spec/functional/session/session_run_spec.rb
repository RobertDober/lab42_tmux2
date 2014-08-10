require 'spec_helper'

describe T::Session do 
  context 'run' do 
    it 'raises an error if there is no session' do
      expect( ->{
        described_class.run
      } ).to raise_error T::NoSessionDefined, 'you need to define a session with `new_session` in your script' 
    end
    context 'with session', :wip do
      let( :session_name ){ 'my-sess' }
      
      before do
        stub_tmux_command
        stub_tmux_query session_name, false # as if the session does not exist
      end
      it 'an empty session opens only one window' do
        described_class.new session_name
        expect( output ).to eq [
        ]
      end

    end # context 'with session'
  end # context 'run'
end # describe T::Session
