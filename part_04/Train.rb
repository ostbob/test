class Train
  attr_reader :carriage_number, :velocity, :type
  attr_accessor :route, :station

  def initialize(id, type, carriage_number, velocity = 0)
    @id = id
    @type = type
    @carriage_number = carriage_number
    @velocity = velocity
  end

  def end_move
    @velocity = 0
  end

  def start_move
    @velocity = 100
  end

  def current_speed
    return @velocity
  end

  def set_route(route)
    @route = route
    @station = route.stations.first
  end

  def decrease_carriage_number
    if @velocity == 0 && @carriage_number > 0
      @carriage_number -= 1
    end
  end

  def increase_carriage_number
    if @velocity == 0
      @carriage_number += 1
    end
  end

  def move_forward
    if next_station != nil
      @station = next_station
    end
  end
  def move_back
    if previous_station != nil
      @station = previous_station
    end
  end

  def current_station
    return @station
  end

  def current_index
    return @route.stations.find_index(@station)
  end

  def previous_station
    return @route.stations[current_index - 1]
  end

  def next_station
    return @route.stations[current_index + 1]
  end

end


