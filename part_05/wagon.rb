# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'validation'

class Wagon
  include Manufacturer
  include Validation

  attr_reader :type
  validate :type, :presence

  def initialize(type)
    @type = type
    validate!
  end
end
