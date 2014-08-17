require 'spec_helper'

describe T::Config do 

  subject do
    described_class.new
  end

  context 'pre_wait_interval' do 
    it 'defaults to nil' do
      expect( subject.pre_wait_interval ).to be_nil
    end
    it 'but it can be set' do
      subject.pre_wait_interval 0.1
      expect( subject.pre_wait_interval ).to eq 0.1
    end
  end # context 'pre_wait_interval'
  
  context 'post_wait_interval' do 
    it 'defaults to nil' do
      expect( subject.post_wait_interval ).to be_nil
    end
    it 'but it can be set' do
      subject.post_wait_interval 0.1
      expect( subject.post_wait_interval ).to eq 0.1
    end
  end # context 'pre_wait_interval'

  context 'wait_interval' do 
    it 'defaults to 0.5s' do
      expect( subject.wait_interval ).to eq 0.5
    end
    it 'but it can be set' do
      subject.wait_interval 0.1
      expect( subject.wait_interval ).to eq 0.1
    end
  end # context 'wait_interval'


  context 'wait_timeout' do 
    it 'defaults to 2s' do
      expect( subject.wait_timeout ).to eq 2
    end
    it 'but it can be set' do
      subject.wait_timeout 0.1
      expect( subject.wait_timeout ).to eq 0.1
    end
  end # context 'wait_timeout'
end # describe T::Config
