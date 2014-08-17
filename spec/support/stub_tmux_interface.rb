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
    return_value =
      if Hash === expectation.last
        expectation.pop
      end
    return_value &&= return_value.fetch :returns
    expect( Lab42::Tmux::Interface ).to receive( :query ).with( *expectation ).ordered.and_return return_value
  end

  # TODO: Allow last param to sepcify a return value (which defaults to '')
  def set_command_expectation *expectation
    return_value =
      if Hash === expectation.last
        expectation.pop
      end
    return_value &&= return_value.fetch :returns
    expect( Lab42::Tmux::Interface ).to receive( :command ).with( *expectation ).ordered.and_return return_value
  end

  def stub_interface
    allow( Lab42::Tmux::Interface ).to receive( :command )
    allow( Lab42::Tmux::Interface ).to receive( :query )
  end
end # module CommandInterfaceStub
  
RSpec.configure do | c |
  c.include CommandInterfaceStub
end
