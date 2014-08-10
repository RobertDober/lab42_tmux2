module CommandInterfaceStub

  def output
    @output ||= []
  end

  def stub_tmux_command
    output.clear
    o = output
    class << T::Interface; self end.module_eval do
      define_method :command do | *args |
        o << args.join( ' ' )
      end
    end
    # allow( T::Interface ).to receive :command do |*args|
    #   @output << args.join( ' ' )
    # end
  end
  

  def stub_tmux_query session, result
    expect( T::Interface ).to receive( :query ).with( 'has-session', '-t', session ){ result }
  end
end # module CommandInterfaceStub
  
RSpec.configure do | c |
  c.include CommandInterfaceStub
end
