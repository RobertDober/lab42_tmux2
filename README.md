
# Lab42, Programmers' Best Friend In Ruby 2

## Tmux2

**N.B.** This is a complete rewrite of tmux and it is **not** compatible, IOW do not
install both gems.

These are the differences

* Everything has changed.

* Furthermore, nothing has remained the same

* There are no predefined scripts, but have a look at the examples.

## Purpose

A simple API for launching tmux sessions from Ruby scripts

### A simple example

```ruby
    require 'lab42/tmux/autoimport'

    session "vi_session" do
      configure do | c |
        c.home '.'                  # Would have been the default
        c.session_name = ARGV.first # Would have been the default
      end
      new_window 'vi' do
        send_keys 'vi .'
        wait_for '.. (up a dir)' # NERDTree pane has loaded
        send_keys_raw 'C-w', 'l'
      end
      new_window 'pry' do
        send_keys 'pry -Ilib'
        send_keys 'require "lab42/tmux"'
      end
    end
```


## Dev Notes

### Acceptance Tests

For each example script there is a corresponding expecatation output in the
`expectations` directory. Use the acceptance_tests script to run the examples
and compare the output with the expectations.


The expectation files are primitive and need some simple adaptations to your environment, hopefully
that will change.
