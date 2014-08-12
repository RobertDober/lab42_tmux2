
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
        c.home '.'                     # Would have been the default
        c.window_automatic_rename true # Default is false
      end
      new_window 'vi' do
        send_keys 'vi .'
        wait_for '.. (up a dir)'       # NERDTree pane has loaded (not yet implemented)
        send_keys_raw 'C-w', 'l'
      end
      new_window 'pry' do
        send_keys 'pry -Ilib'
        send_keys 'require "lab42/tmux"'
      end
    end
```

### Hooks

Add a `after_new_window` hook for tmux commands to be executed after the creation of a new
window.

```ruby
    session 'my rails' do
      after_new_window do
        send_keys "rvm use default@my-rails"
      end
      # ...
    end
```


### Plugins

Plugins are easy to write, just MP the `Lab42::Tmux::Session` class. However precise guidelines
how to do this will be available soon, also you might want to create some configuration.

The plugin guidelines and some plugins (vi, ruby, rvm, python's virtualenv) are planned for
the near future.

## Dev Notes

### Acceptance Tests

For each example script there is a corresponding expecatation output in the
`expectations` directory. Use the acceptance_tests script to run the examples
and compare the output with the expectations.


The expectation files are primitive and need some simple adaptations to your environment, hopefully
that will change.
