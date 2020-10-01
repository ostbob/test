require_relative './instance_counter'

class Route
  attr_reader :name, :start_station, :end_station, :stations

  include InstanceCounter

  def initialize(name, start_station, end_station)
    @name = name
    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  # Это public, потому что они могут использоваться как интерфейс к объекту
  def add_station(station)
    @stations.insert(stations.length-1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private
  def validate!
    raise "Name can't be nil." if @name.nil?
    raise "Start station can't be nil" if @stations[0].nil?
    raise "End station can't be nil" if @stations[-1].nil?
  end

end

