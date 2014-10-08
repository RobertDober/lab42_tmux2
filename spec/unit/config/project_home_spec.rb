require 'spec_helper'

describe T::Config do
  subject do
    described_class.new
  end

  context 'project_home' do
    it "defaults to $0's directory" do
      expect( subject.project_home ).to eq PROJECT_HOME
    end
    it 'but it can be changed' do
      subject.session_name 'my_proj'
      expect( subject.session_name ).to eq 'my_proj'
    end
  end # context 'session_name'
  
end # describe T::Config
