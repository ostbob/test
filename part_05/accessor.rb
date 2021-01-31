# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # rubocop:disable Metrics/MethodLength
    def attr_accessor_with_history(*names)
      names.each do |name|
        define_method name do
          instance_variable_get("@#{name}")
        end

        define_method "#{name}=" do |new_value|
          history = instance_variable_get("@#{name}_history") || []
          history << new_value
          instance_variable_set("@#{name}_history", history)
          instance_variable_set("@#{name}", new_value)
        end

        define_method "#{name}_history" do
          instance_variable_get("@#{name}_history") || []
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def strong_attr_accessor(attribute, class_name)
      define_method attribute do
        instance_variable_get("@#{attribute}")
      end

      define_method "#{attribute}=" do |new_value|
        instance_variable_set("@#{attribute}", new_value) if new_value.is_a? class_name
        raise ArgumentError, 'Incorrect argument type' unless new_value.is_a? class_name
      end
    end
  end
end
