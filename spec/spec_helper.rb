require_relative "../lib/lab42/tmux/auto_import"

PROJECT_ROOT = File.expand_path "../..", __FILE__
Dir[File.join(PROJECT_ROOT,"spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |c|
  c.filter_run wip: true
  c.filter_run_excluding slow: true
  c.filter_run_excluding next: true
  c.run_all_when_everything_filtered = true
end

