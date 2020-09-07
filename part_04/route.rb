class Route
  attr_reader :start_station, :end_station, :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(stations.length-1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

end

