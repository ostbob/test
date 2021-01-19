# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'accessor'

class Train
  @trains = []

  class << self
    attr_accessor :trains
  end

  include Manufacturer
  include InstanceCounter
  include Accessors

  attr_reader :id, :type, :route
  strong_attr_accessor :station, Station
  attr_accessor_with_history :speed
  attr_accessor :wagons

  ID_FORMAT = /^[\w\d]{3}-?[\w\d]{2}$/i.freeze

  def initialize(id, type, speed = 0)
    @id = id
    @type = type
    @speed = speed
    validate!
    @wagons = []
    Train.trains << self
    register_instance
  end

  def self.find(id)
    @trains.each { |train| return train if train.id == id }
    nil
  end

  def end_move
    @speed = 0
  end

  def start_move
    @speed = 100
  end

  def route=(route)
    @route = route
    @station = route.stations.first
    @station.take_train(self)
  end

  def delete_wagon
    @wagons.delete_at(@wagons.length - 1) if @speed.zero? && @wagons.length.positive?
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && wagon.type == type
  end

  def move_forward
    return if next_station.nil?

    @station.send_train(self)
    @station = next_station
    @station.take_train(self)
  end

  def move_back
    return if previous_station.nil?

    @station.send_train(self)
    @station = previous_station
    @station.take_train(self)
  end

  def wagons_block_method
    @wagons.each_with_index do |wagon, index|
      yield wagon, index
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

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
    raise 'Speed must be greater than zero' if @speed.negative?
    raise 'ID has invalid format.' if id !~ ID_FORMAT
  end
end
