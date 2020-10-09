require_relative 'manufacturer'
require_relative 'instance_counter'

class Train

  @@trains = []

  include Manufacturer
  include InstanceCounter

  attr_reader :id, :speed, :type
  attr_accessor :route, :station, :wagons

  ID_FORMAT = /^[\w\d]{3}-?[\w\d]{2}$/i

  def initialize(id, type, speed = 0)
    @id = id
    @type = type
    @speed = speed
    validate!
    @wagons = []
    @@trains << self
    register_instance
  end

  def self.find(id)
    @@trains.each {|train| return train if train.id == id }
    return nil
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
  
  def wagons_block_method(&block)
    @wagons.each_with_index do |wagon, index|
      yield wagon, index
    end
  end

  def valid?
    validate!
    true
  rescue
    false
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

  def validate!
    raise "ID can't be nil" if @id.nil?
    raise "Type can't be nil" if @type.nil?
    raise "Speed must be greater than zero" if @speed < 0
    raise "ID has invalid format." if id !~ ID_FORMAT
  end

end
