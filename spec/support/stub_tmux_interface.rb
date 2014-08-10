module CommandInterfaceStub

  def output
    @output ||= []
  end

  def stub_tmux_command
    output.clear
    allow( T::Interface ).to receive :command do |*args|
      @output << args.join( ' ' )
    end
  end
  

  def stub_tmux_query session, result
    expect( T::Interface ).to receive( :query ).with( 'has-session', '-t', session ){ result }
  end
end # module CommandInterfaceStub
  
RSpec.configure do | c |
  c.include CommandInterfaceStub
end
