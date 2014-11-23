
# Lab42 Programmer's Best Friend In Ruby2


[![Build Status](https://travis-ci.org/RobertDober/lab42_tmux2.svg?branch=master)](https://travis-ci.org/RobertDober/lab42_tmux2)
[![Code Climate](https://codeclimate.com/github/RobertDober/lab42_tmux2/badges/gpa.svg)](https://codeclimate.com/github/RobertDober/lab42_tmux2)
[![Test Coverage](https://codeclimate.com/github/RobertDober/lab42_tmux2/badges/coverage.svg)](https://codeclimate.com/github/RobertDober/lab42_tmux2)

## lab42_Tmux2

**N.B.** This is a complete rewrite of lab42_tmux and it is **not** compatible, IOW do not
install both gems, they even occupy the same namespace.

These are the differences

* Everything has changed.

* Furthermore, nothing has remained the same.

* There are no predefined scripts, but have a look at the examples.

## Purpose

A simple API for launching tmux sessions from Ruby scripts

### A simple example

```ruby
    require 'lab42/tmux/auto_import'

    session "vi_session" do
      new_window 'vi' do
        send_keys 'vi .'
      end
      new_window 'pry' do
        send_keys 'pry -Ilib'
        send_keys 'require "lab42/tmux"'
      end
    end
```

If a session named `vi_session` exists this will simply attach to it, thus the script is protected  against multiple executions.

Otherwise this will open a new tmux session named `vi_session` and do the following:

* Source ~/.tmux.conf

* Change every window to the directory in which this script resides (can be changed in a `config` block as shown below) 

* execute commands for the default window or other windows as specified above

For the time being this gem assumes you are not rebasing the window count in your config file.

### Configuration

```ruby
    require 'lab42/tmux/auto_import'

    config do
      window_automatic_rename true    # now there will be no `set-window-option -g automatic-rename off`
    end

    session "sh-session" do
      new_window 'console'            # opens a second window
    end

```

#### Configuration of `project_home`

By default `project_home` will be set to the directory of the client script (aka `File.dirname $0`), this can be changed in two ways:

```ruby
    # ...
    config do
      project_home "/home/worxpace" # used instead of File.dirname $0
      # or
      project_home nil              # remain in dir in which client script was launched
    end
```


### Hooks

Add an `after_new_window` hook for tmux commands to be executed after the creation of a new
window.

```ruby
    session 'my rails' do
      after_new_window do
        send_keys "rvm use default@my-rails"
      end
      # ...
    end
```

### Window Events

The real use case for which Ruby was much better than shell scripts was the `wait_for` method
as it allows us to wait for some text in a pane to be shown before doing some action.

This is a real use case which will open vi with _NERDTree_, wait for NERDTree to split panes
and only then switch to the right hand side split pane (of vi, not tmux).

```ruby

    config
      # options for wait_for
      pre_wait_interval 0.1  # Before checking for text in s, defaults to nil
      post_wait_interval 0.1 # After text has shown up in pane, defaults to nil
      wait_timeout 4         # Do not wait longer than that, defaults to 2s

      verbose true           # Talk to stdout for post mortem analyse
    end

    new_session 'lab42_core' do
      new_window 'vi' do
        send_keys 'vi .'
        wait_for "up a dir" do     # Block will be executed iff text appears 
                                   # before timeout only
          send_keys_raw 'C-w', 'l'
          send_keys ':e README.md'
          send_keys ':so local.vim'
          send_keys_raw 'ziG'
        end
        # Script continues after timeout or appearance of text
        # ...
      end
end
```

### Plugins

Plugins are easy to write, just MP the `Lab42::Tmux::Session` class. However precise guidelines
how to do this will be available soon, also you might want to create some configuration.

However, the goal of plugins being to be combineable the `lab42_tmux2` gem offers a mechanism to
protect plugins from each other. This works as follows:

#### A Vim Plugin

##### Commands, The Easy One

Instead of MPatching Lab42::Tmux::Session::Commands you just write your own module of commands, e.g.

```ruby
    require 'lab42/tmux/auto_import'
    module VimCommands
      def vim_window name, **options
        new_window name do
          send_keys "vi #{options.fetch :dir, '.'}"
          if options[:nerdtree]
            send_keys_raw 'C-w', 'l'
          end
        end
      end
    end
```

Now you _register_ the plugin via `Lab42::Tmux::Plugins.register VimCommands`, the benefit of doing this is, that
the plugin will not overwrite other plugins that might have implemented  a `vim_window` command, and later plugins, that
on their account want to define a `vim_window` command will not be able to overwite yours.

##### Configuration, A Little Bit More Complicated

**Not yet implemented c.f. Issues**

Imagine, and it is quite useful as explained above, that whenever we use the plugin we want to have a changed default configuration.
In our case we want to set a `pre_waint_interval` and a `post_wait_interval` by default. We could simply invoke
`Lab42::Tmux::Session.config{ ... }` but we would be exposed to the same dangers as above, _breaking_ and _being broken_.

Although conflicts might still arise, it is much saver to wrap our methods in a `with_config` block, that adds temporary configuration

```ruby
    # ...
    def vim_window name, **options
      # config.pre_wait_interval.nil?
      with_config pre_wait_interval: 0.1 do
        # config.pre_wait_interval == 0.1
        # other config values are unchanged
        # ...
      end
      # config.pre_wait_interval.nil?
    end
```

## Dev Notes

### Acceptance Tests

For each example script there is a corresponding expecatation output in the
`expectations` directory. Use the acceptance_tests script to run the examples
and compare the output with the expectations.


The expectation files are primitive and need some simple adaptations to your environment, hopefully
that will change.
