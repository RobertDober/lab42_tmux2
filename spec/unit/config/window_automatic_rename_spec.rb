require 'spec_helper'

describe T::Config do 

  subject do
    described_class.new
  end

  context 'window_automatic_rename' do 
    it 'defaults to nil' do
      expect( subject.window_automatic_rename ).to be_nil
    end
    it 'but it can be set' do
      subject.window_automatic_rename true
      expect( subject.window_automatic_rename ).to eq true
    end
  end # context 'window_automatic_rename'
  
end # describe T::Config
