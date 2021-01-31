# frozen_string_literal: true

require_relative './instance_counter'
require_relative './validation'

class Route
  attr_reader :name, :start_station, :end_station, :stations

  include InstanceCounter
  include Validation

  validate :name, :presence
  validate :name, :type, String

  def initialize(name, start_station, end_station)
    @name = name
    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(stations.length - 1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
