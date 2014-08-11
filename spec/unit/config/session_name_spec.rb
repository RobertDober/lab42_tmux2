require 'spec_helper'

describe T::Config do 
  subject do
    described_class.new
  end

  context 'session_name' do 
    it 'defaults to nil' do
      expect( subject.session_name ).to be_nil
    end
    it 'but it can be set' do
      subject.session_name 'my_sess'
      expect( subject.session_name ).to eq 'my_sess'
    end
  end # context 'session_name'
  
end # describe T::Config
