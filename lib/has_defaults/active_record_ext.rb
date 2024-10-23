module HasDefaults

  class Error < StandardError; end

  module ActiveRecordExt

    module ClassMethods

      def has_defaults(attrs)
        raise Error, "Hash expected; #{attrs.class} given." unless attrs.is_a?(Hash)

        include InstanceMethods

        # Check if our parent class had default options, whose accessor we inherited.
        # In this case we clone the default options as to not modify the options of our parent.
        if respond_to?(:has_defaults_options)
          self.has_defaults_options = has_defaults_options.dup
        else
          # Rails 3 and 2 have different copy-and-write accessor generators.
          if respond_to?(:class_attribute)
            class_attribute :has_defaults_options
          else
            class_inheritable_hash :has_defaults_options
          end
          # We only register the callback if we haven't registered it before,
          # since in this branch we didn't inherit #has_defaults_options
          after_initialize :set_default_attributes
        end

        self.has_defaults_options ||= {}
        self.has_defaults_options.merge!(attrs)

        if ActiveRecord::VERSION::MAJOR < 3
          # ActiveRecord only calls after_initialize callbacks only if is
          # explicit defined in a class. We should however only define that
          # callback if a default has been set, as it really slow downs Rails.
          unless method_defined?(:after_initialize)
            define_method(:after_initialize) {}
          end
        end

      end

    end

    module InstanceMethods

      def default_for(name)
        raw_value = self.class.has_defaults_options[name.to_sym]
        evaluate_raw_default_value(raw_value)
      end

      private

      def set_default_attributes
        if new_record?
          self.class.has_defaults_options.each do |name, raw_value|
            if send(name).nil?
              value = evaluate_raw_default_value(raw_value)
              send("#{name}=", value)
            end
          end
        end
      end

      def evaluate_raw_default_value(raw_value)
        value = raw_value
        if value.respond_to?(:call)
          value = instance_exec(&value)
        end
        value
      end

    end

  end
end

ActiveSupport.on_load(:active_record) do
  extend(HasDefaults::ActiveRecordExt::ClassMethods)
end
