require 'spec_helper'

describe T::Plugins do
  before{ described_class.registered.clear }
  context '.register' do 
    let( :mod ){ Module.new{ def a; 42 end } }
    before{ described_class.register mod }

    it 'can register a module' do
      expect( T::Session.new('a').a ).to eq 42
    end

    it 'cannot register the same method twice' do
      expect{ described_class.register( Module.new{ def a; 21 end } ) }.to raise_error T::Plugins::Conflict
    end

  end # context '.register'
end # describe T::Plugins
