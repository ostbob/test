# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validators
      @validators ||= []
    end

    def validate(parameter, validation_type, additional_parameter = nil)
      validators << [parameter, validation_type, additional_parameter]
    end
  end

  module InstanceMethods
    # rubocop:disable Metrics/MethodLength
    def validate!
      self.class.validators.each do |validator|
        case validator[1]
        when :presence
          validate_presence(validator[0])
        when :format
          validate_format(validator[0], validator[2])
        when :type
          validate_type(validator[0], validator[2])
        else
          puts 'No such validation type.'
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def validate_presence(parameter)
      parameter_value = instance_variable_get("@#{parameter}")
      raise ArgumentError, 'Parameter is nill.' if parameter_value.nil? || parameter_value == ''
    end

    def validate_format(parameter, format)
      parameter_value = instance_variable_get("@#{parameter}")
      raise ArgumentError, 'Invalid format' if parameter_value !~ format || format.nil?
    end

    def validate_type(parameter, type)
      parameter_value = instance_variable_get("@#{parameter}")
      raise ArgumentError, 'Invalid type' if !parameter_value.is_a?(type) || type.nil?
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end
  end
end
