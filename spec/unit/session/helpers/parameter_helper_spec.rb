require 'spec_helper'

describe Lab42::Tmux::Session do
  before do
    stub_interface
  end
  context 'parameter helpers' do 
    
    let( :session_name ){ 'session-name' }
    subject do
      described_class.new session_name
    end

    context 'session address' do 
      it 'is correctly computed' do
        expect( subject.session_address ).to eq "-t #{session_name}"
      end
    end # context 'session address'

    context 'window address is correctly computed' do 
      it 'for implicit window' do
        expect( subject.window_address ).to eq "-t #{session_name}:0"
      end
      it 'for other windows' do
        3.times{ subject.new_window '' }
        expect( subject.window_address ).to eq "-t #{session_name}:3"
      end
    end # context 'window address'
    
  end # context 'parameter helpers'
end # describe Lab42::Tmux::Session

