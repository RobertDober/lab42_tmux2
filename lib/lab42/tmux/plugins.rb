require 'set'
require_relative 'plugins/conflict'
module Lab42
  module Tmux
    module Plugins extend self
      @registered = Set.new
      attr_reader :registered

      def register a_module, as: nil
        if as
          # Not yet implemented
          raise ArgumentError 'as: is not yet implemented'
          register_namespaced a_module, as
        else
          register_directly a_module
        end
      end

      private
      def register_directly a_module
        conflicts = []
        a_module.instance_methods.each do | im_name |
          conflicts << im_name if registered.include? im_name
          registered << im_name
        end
        raise Conflict unless conflicts.empty?
        
        Session.send :include, a_module
      end
    end
  end # module Tmux
end # module Lab42
