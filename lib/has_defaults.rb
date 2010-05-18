module SimplesIdeias
  module Acts
    module Defaults
      def self.included(base)
        base.extend ClassMethods
      end
      
      module ClassMethods

        def has_defaults(attrs)
          raise "Hash expected; #{attrs.class} given." unless attrs.is_a?(Hash)
          
          include SimplesIdeias::Acts::Defaults::InstanceMethods
          
          unless respond_to?(:has_defaults_options)
            class_inheritable_hash :has_defaults_options
          end

          self.has_defaults_options ||= {}
          self.has_defaults_options.merge!(attrs)
          
          # ActiveRecord only calls after_initialize callbacks only if is
          # explicit defined in a class. We should however only define that
          # callback if a default has been set, as it really slow downs Rails.
          unless method_defined?(:after_initialize)
            define_method(:after_initialize) {}
          end
          
          after_initialize :set_default_attributes
        end

      end
      
      module InstanceMethods
      
        def default_for(name)
          self.class.has_defaults_options[name.to_sym]
        end
        
        private
        
        def set_default_attributes
          if new_record?
            self.class.has_defaults_options.each do |name, value|
              value = value.call if value.respond_to?(:call)
              send("#{name}=", value) if send(name).nil?
            end
          end
        end
        
      end
    end
  end
end
