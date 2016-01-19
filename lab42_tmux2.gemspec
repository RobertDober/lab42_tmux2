require_relative 'lib/lab42/tmux/version'

version = Lab42::Tmux::VERSION

Gem::Specification.new do |s|
  s.name        = 'lab42_tmux2'
  s.version     = version
  s.summary     = "Creating Tmux Windows And Panes Without Pains"
  s.description = %{Create sessions with multiple windows from ruby}
  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  # s.files      += Dir.glob("bin/*")
  s.bindir      = "bin"
  s.files      += %w{LICENSE README.md}
  s.executables = Dir.glob("bin/*").map{ |f| f.sub(%r{bin/},"") }
  s.homepage    = "https://github.com/RobertDober/lab42_tmux2"
  s.licenses    = %w{MIT}

  s.required_ruby_version = '>= 2.2'
  # s.add_dependency 'lab42_options', '~> 0.4'
  s.add_dependency 'lab42_core', '~> 0.1.1'
  s.add_dependency 'forwarder2', '~> 0.2'

  s.add_development_dependency 'pry', '~> 0.9.12'
  s.add_development_dependency 'pry-nav', '~> 0.2.4'
  s.add_development_dependency 'rspec', '~> 3.0'
end
