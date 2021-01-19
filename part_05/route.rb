# frozen_string_literal: true

require_relative './instance_counter'
require_relative './validation'

class Route
  attr_reader :name, :start_station, :end_station, :stations

  include InstanceCounter
  include Validation

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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise "Name can't be nil." if @name.nil?
    raise "Start station can't be nil" if @stations[0].nil?
    raise "End station can't be nil" if @stations[-1].nil?
  end
end
