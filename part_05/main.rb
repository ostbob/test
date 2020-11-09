# frozen_string_literal: true

require 'highline'

require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

class Main
  def initialize
    @trains = {}
    @stations = {}
    @routes = {}
    @wagons = {}
  end

  def start
    cli = HighLine.new
    loop do
      exit = false
      cli.choose do |menu|
        puts "\n\n\n============================================================================\n\n\n"
        menu.prompt = 'Please choose your option.'
        menu.choice('Create new station', text: 'Create new station') { create_new_station }
        menu.choice('Create new train', text: 'Create new train') { create_new_train }
        menu.choice('Create new route', text: 'Create new route') { create_new_route }
        menu.choice('Manage existing route', text: 'Manage route') { manage_route }
        menu.choice('Assign route to train', text: 'Assign route to train') { assign_route_to_train }
        menu.choice('Add wagon to train', text: 'Add wagon to train') { add_wagon_to_train }
        menu.choice('Delete wagon from train', text: 'Delete wagon') { delete_wagon_from_train }
        menu.choice('Move train', text: 'Move') { move_train }
        menu.choice('Take seats or volume of train wagon', text: 'Take seats or volume') { take_seats_or_volume }
        menu.choice('Show train wagons', text: 'Show train wagons') { show_train_wagons }
        menu.choice('Show stations and trains', text: 'show stations and trains') { show_stations_and_trains }
        menu.choice('Exit', text: 'Exit') { exit = true }
        menu.default = '...'
      end

      break if exit
    end
  end

  private

  def create_new_train
    puts 'Creating new train. Input new train id like XXX-XX:'
    id = gets.chomp
    puts 'Creating new train. Input train speed ...'
    speed = gets.chomp.to_f
    puts 'Creating new train. Input type: passenger or cargo ...'
    type = gets.chomp.downcase.to_sym
    @trains[id.to_sym] = Train.new(id, type, speed)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_new_station
    puts 'Create new station ...'
    puts 'Input new station name ...'
    name = gets.chomp

    station = Station.new(name)
    @stations[name.to_sym] = station
  end

  def find_station_by_name
    name = gets.chomp.to_sym
    unless @stations.key?(name)
      puts 'No such station in dictionary ... Exit.'
      return nil
    end

    @stations[name]
  end

  def create_new_route
    puts 'Creating new route: input new route name ...'
    name = gets.chomp
    puts 'Creating new route: input start station ...'
    start_station = find_station_by_name
    return if start_station.nil?

    puts 'Creating new route: input end station ...'
    end_station = find_station_by_name
    return if end_station.nil?

    route = Route.new(name, start_station, end_station)
    @routes[name.to_sym] = route
  end

  def add_station_to_route(route_name)
    puts 'Input station name ...'
    name = gets.chomp
    unless @stations.key?(name.to_sym)
      puts 'No such station ...'
      return
    end
    @routes[route_name].add_station(@stations[name.to_sym])
  end

  def delete_station_from_route(route_name)
    puts 'Input station name ...'
    name = gets.chomp
    unless @stations.key?(name.to_sym)
      puts 'No such station'
      return
    end
    @routes[route_name].delete_station(@stations[name.to_sym])
  end

  def find_route_by_name
    puts 'Input route name ...'
    name = gets.chomp
    unless @routes.key?(name.to_sym)
      puts 'No such route ...'
      return nil
    end

    @routes[name.to_sym]
  end

  def manage_route
    route = find_route_by_name
    return if route.nil?

    route_cli = HighLine.new
    route_cli.choose do |menu|
      menu.prompt = 'Choose route option.'
      menu.choice('Add station', text: 'add station') { add_station_to_route(route.name) }
      menu.choice('Delete station', text: 'delete station') { delete_station_from_route(route.name) }
      menu.choice('Show stations', text: 'show stations') { show_stations(route.stations) }
    end
  end

  def assign_route_to_train
    puts 'Input route name ...'
    name = gets.chomp
    unless @routes.key?(name.to_sym)
      puts 'No such route ...'
      return
    end

    train = find_train_by_id
    return if train.nil?

    train.route = @routes[name.to_sym]
  end

  def add_wagon_to_train
    train = find_train_by_id
    return if train.nil?

    puts 'Input wagon volume or seat number ...'
    volume_or_seat_number = gets.chomp
    wagon = if train.type == :cargo
              CargoWagon.new(volume_or_seat_number.to_f)
            else
              PassengerWagon.new(volume_or_seat_number.to_i)
            end
    train.add_wagon(wagon)
  end

  def delete_wagon_from_train
    puts 'Input train id ...'
    id = gets.chomp
    unless @trains.key?(id.to_sym)
      puts 'No such train ...'
      return
    end

    @trains[id.to_sym].delete_wagon
  end

  def move_train
    train = find_train_by_id
    return if train.nil?

    if train.route.nil?
      puts 'No route for this train'
      return
    end

    move_train_forward_or_back(train)
  end

  def move_train_forward_or_back(train)
    train_cli = HighLine.new
    train_cli.choose do |menu|
      menu.prompt = 'Choose train option.'
      menu.choice('Move forward', text: 'Move') { train.move_forward }
      menu.choice('Move back', text: 'Move') { train.move_back }
    end
  end

  def find_train_by_id
    puts 'Input train id ...'
    id = gets.chomp

    unless @trains.key?(id.to_sym)
      puts 'No such train id ...'
      return nil
    end

    @trains[id.to_sym]
  end

  def take_seats_or_volume
    train = find_train_by_id
    return if train.nil?

    puts 'Input wagon id ...'
    wagon_id = gets.chomp.to_i - 1
    if train.wagons[wagon_id].nil?
      puts 'No such wagon id ...'
      return
    end

    occupy_wagon(train.wagons[wagon_id])
  end

  def occupy_wagon(wagon)
    if wagon.type == :cargo
      puts 'Input wagon required volume ...'
      volume = gets.chomp.to_f
      wagon.occupy_volume(volume)
    elsif wagon.type == :passenger
      puts 'Taking wagon seat for passenger ...'
      wagon.take_seat
    end
  end

  def show_train_wagons
    puts 'Input train id ...'
    id = gets.chomp
    unless @trains.key?(id.to_sym)
      puts 'No such train ...'
      return
    end

    print_train_wagons(@trains[id.to_sym])
  end

  def print_train_wagons(train)
    puts "Printing information for train #{train.id}..."
    train.wagons_block_method do |wagon, index|
      puts "wagon id: #{index + 1}, type: #{wagon.type}"
      if wagon.type == :cargo
        puts "   free volume: #{wagon.free_volume}, occupied volume: #{wagon.occupied_volume}"
      else
        puts "   free seats: #{wagon.free_seats}, taken seats: #{wagon.taken_seats}"
      end
    end
  end

  def show_stations_and_trains
    Station.all.each do |station|
      puts "Printing data for stations #{station.name}: "
      station.trains_block_method do |train|
        puts "Train id: #{train.id}, type: #{train.type}, wagons: #{train.wagons.length}"
        print_train_wagons(train)
      end
      puts '-------------------------------------------'
    end
  end

  def show_stations(stations)
    puts stations.inspect
  end

  def show_trains
    puts @trains.to_s
  end
end

Main.new.start
