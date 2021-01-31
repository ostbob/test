# frozen_string_literal: true

require_relative './instance_counter'
require_relative 'validation'

class Station
  @stations = []

  class << self
    attr_accessor :stations
  end

  attr_reader :name, :trains

  include InstanceCounter
  include Validation

  validate :name, :presence

  def initialize(name)
    @name = name
    validate!
    @trains = []
    Station.stations << self
    register_instance
  end

  def self.all
    @stations
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def passenger_train_list
    @trains.select { |train| train.type == :passenger }
  end

  def cargo_train_list
    @trains.select { |train| train.type == :cargo }
  end

  def trains_block_method
    @trains.each do |train|
      yield train
    end
  end
end
