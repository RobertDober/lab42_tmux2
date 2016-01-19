require 'spec_helper'

describe T::Session do 
  let( :session_name ){ 'dummy' }
  
  before do
    stub_tmux_command
    stub_tmux_query session_name, false # as if the session does not exist
  end
  context 'define' do
    let( :title ){ 'window-title' }
    subject do
      described_class.new session_name
    end

    # it 'runs the block' do
    #   expect( subject ).to receive(:new_window).with( title )
    #   subject.define ->{
    #     new_window title
    #   }
    # end
    
  end # context 'define'
end # describe T::Session
