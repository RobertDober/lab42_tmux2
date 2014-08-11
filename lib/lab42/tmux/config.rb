module Lab42
  module Tmux
    class Config

      def self.define_setter_getter name
        define_method name do |*args|
          return instance_variable_get("@#{name}") if args.empty?
          instance_variable_set "@#{name}", args.first
        end
      end

      def self.define_setter_getters *names
        names.each do | name |
          define_setter_getter( name )
        end
      end

      define_setter_getters :session_name, :window_automatic_rename

      private
      def initialize
      end
    end # module Config
  end # module Tmux
end # module Lab42
