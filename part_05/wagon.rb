# frozen_string_literal: true

require_relative 'manufacturer'

class Wagon
  include Manufacturer
  attr_reader :type
  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    "Type can't be nil" if @type.nil?
  end
end
