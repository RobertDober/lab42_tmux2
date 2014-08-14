module CommandInterfaceStub

  def set_interface_expectations *expectations
    expectations.each do | expectation |
      set_interface_expectation( *expectation )
    end
  end

  def set_interface_expectation *expectation
    if expectation.first.to_sym == :query
      set_query_expectation( *expectation.drop( 1 ) )
    elsif expectation.first.to_sym == :command
      set_command_expectation( *expectation.drop( 1 ) )
    # Allow the ugly default for command
    else
      set_command_expectation( *expectation )
    end
  end
  
  def set_query_expectation *expectation
    expect( Lab42::Tmux::Interface ).to receive( :query ).with( *expectation ).ordered.and_return false
  end

  # TODO: Allow last param to sepcify a return value (which defaults to '')
  def set_command_expectation *expectation
    expect( Lab42::Tmux::Interface ).to receive( :command ).with( *expectation ).ordered.and_return ''
  end
end # module CommandInterfaceStub
  
RSpec.configure do | c |
  c.include CommandInterfaceStub
end
