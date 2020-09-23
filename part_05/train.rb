class Train
  attr_reader :id, :speed, :type
  attr_accessor :route, :station, :wagons

  def initialize(id, type, speed = 0)
    @id = id
    @type = type
    @speed = speed
    @wagons = []
  end

  # Это public, потому что могут напрямую использоваться как интерфейс к объекту 
  def end_move
    @speed = 0
  end

  def start_move
    @speed = 100
  end

  def set_route(route)
    @route = route
    @station = route.stations.first
    @station.get_train(self)
  end

  def delete_wagon()
    if @speed == 0 && @wagons.length > 0
      @wagons.delete_at(@wagons.length-1)
    end
  end

  def add_wagon(wagon)
    if @speed == 0 && wagon.type == self.type
      @wagons << wagon
    end
  end

  def move_forward
    if next_station != nil
      @station.send_train(self)
      @station = next_station
      @station.get_train(self)
    end
  end
  def move_back
    if previous_station != nil
      @station.send_train(self)
      @station = previous_station
      @station.get_train(self)
    end
  end

  # Это private, потому что они используются только внутри этого класса
  private
  def current_station
    @station
  end

  def current_index
    @route.stations.find_index(@station)
  end

  def previous_station
    @route.stations[current_index - 1]
  end

  def next_station
    @route.stations[current_index + 1]
  end

end
