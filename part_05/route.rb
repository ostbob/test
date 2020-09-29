require_relative './instance_counter'

class Route
  attr_reader :name, :start_station, :end_station, :stations

  include InstanceCounter

  def initialize(name, start_station, end_station)
    @name = name
    @stations = [start_station, end_station]
    register_instance
  end

  # Это public, потому что они могут использоваться как интерфейс к объекту
  def add_station(station)
    @stations.insert(stations.length-1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

end

