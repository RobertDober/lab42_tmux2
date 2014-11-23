require 'lab42/tmux/auto_import'
require 'lab42/core/hash'

module VimPlugin

  def vim_command command, params
    send_keys ":#{command} #{params}"
  end

  def vim_new_window name, **options
    new_window name do
      send_keys "vi #{__vim_dir options}"
      __vim_source options
      __vim_colorscheme options
    end
  end

  private

  def __vim_colorscheme options
    options.with_present :colorscheme do | cs |
      vim_command :colorscheme, cs
    end
  end

  def __vim_dir options
    options.fetch :dir, '.'
  end

  def __vim_source options
    options.with_present :source do | source |
      vim_command :source, source
    end
  end

end # module VimPlugin

Lab42::Tmux::Plugins.register VimPlugin
