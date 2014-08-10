require 'spec_helper'

describe T::Config do 

  context 'session_name' do 
    it 'defaults to nil' do
      expect( described_class.session_name ).to be_nil
    end
    it 'but it can be set' do
      described_class.session_name 'my_sess'
      expect( described_class.session_name ).to eq 'my_sess'
    end
  end # context 'session_name'
  
end # describe T::Config
