# frozen_string_literal: true

module Validation
  def validate(value, options = {})
    presence = options[:presence] || nil
    format = options[:format] || nil
    type = options[:type] || nil

    raise ArgumentError, 'Value is nill.' unless presence == true && (value.nil? || value == '')
    raise ArgumentError, 'Invalid format' if value !~ format && !format.nil?
    raise ArgumentError, 'Invalid type' unless value.is_a?(type) && type.nil?
  end

  def validate!(value, options = {})
    validate(value, options)
  end

  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end
end
