class Route
  attr_reader :start_station, :end_station, :stations

  def initialize(start_station, end_station)
    @stations = []
    @stations << start_station
    @stations << end_station
  end

  def add_station(station)
    @stations.insert(stations.length-1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def print
    @stations.each_with_index {|station, index| puts "#{index} - #{station.name}" }
  end
end

