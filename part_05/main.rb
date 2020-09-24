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
    @trains = Hash.new
    @stations = Hash.new
    @routes = Hash.new
    @wagons = Hash.new
  end

  def start
    cli = HighLine.new
    while true
      exit = false
      cli.choose do |menu|
        puts "\n\n\n============================================================================\n\n\n"
        menu.prompt = 'Please choose your option.'
        menu.choice('Create new station', text: 'Create new station') {create_new_station}
        menu.choice('Create new train', text: 'Create new train') {create_new_train}
        menu.choice('Create new route', text: 'Create new route') {create_new_route}
        menu.choice('Manage existing route', text: 'Manage route') {manage_route}
        menu.choice('Show stations', text: 'Show stations') {puts @stations.map{|station_name, station| "Station #{station_name} : #{station.get_trains}"}}
        menu.choice('Assign route to train', text: 'Assign route to train') {assign_route_to_train}
        menu.choice('Add wagon to train', text: 'Add wagon to train') {add_wagon_to_train}
        menu.choice('Delete wagon from train', text: 'Delete wagon') {delete_wagon_from_train}
        menu.choice('Move train', text: 'Move') {move_train}
        menu.choice('Exit', text: 'Exit') {exit = true}
        menu.default = '...'
      end

      break if exit
    end
  end

  private
  def create_new_train
    puts 'Creating new train ...'
    puts 'Input new train id:'
    id = gets.chomp
    puts 'Input train speed ...'
    speed = gets.chomp.to_f
    puts 'Input type: passenger or cargo ...'
    type = gets.chomp
    
    train = Train.new(id, type.downcase.to_sym, speed)
    @trains[id.to_sym] = train
  end

  def create_new_station
    puts 'Create new station ...'
    puts 'Input new station name ...'
    name = gets.chomp

    station = Station.new(name)
    @stations[name.to_sym] = station
  end

  def create_new_route
    puts 'Create new route ...'
    puts 'Input new route name ...'
    name = gets.chomp
    puts 'Input start station ...'
    start_station = gets.chomp
    if not @stations.key?(start_station.to_sym)
      puts 'No such station in dictionary ...'
      return
    end
    puts 'Input end station ...'
    end_station = gets.chomp
    if not @stations.key?(end_station.to_sym)
      puts 'No such station in dictionary ...'
      return
    end

    route = Route.new(name, @stations[start_station.to_sym], @stations[end_station.to_sym])
    @routes[name.to_sym] = route
  end

  def add_station_to_route(route_name)
    puts 'Input station name ...'
    name = gets.chomp
    if not @stations.key?(name.to_sym)
      puts 'No such station ...'
      return
    end
    @routes[route_name].add_station(@stations[name.to_sym])
  end

  def delete_station_from_route(route_name)
    puts 'Input station name ...'
    name = gets.chomp
    if not @stations.key?(name.to_sym)
      puts 'No such station'
      return
    end
    @routes[route_name].delete_station(@stations[name.to_sym])
  end

  def manage_route
    puts 'Input route name ...'
    name = gets.chomp
    if not @routes.key?(name.to_sym)
      puts 'No such route ...'
      return
    end
    route_cli = HighLine.new
    route_cli.choose do |menu|
      menu.prompt = 'Choose route option.'
      menu.choice('Add station', text: 'add station') {add_station_to_route(name.to_sym)}
      menu.choice('Delete station', text: 'delete station') {delete_station_from_route(name.to_sym)}
      menu.choice('Show stations', text: 'show stations') {show_stations(@routes[name.to_sym].stations)}
    end
  end

  def assign_route_to_train
    puts 'Input route name ...'
    name = gets.chomp
    if not @routes.key?(name.to_sym)
      puts 'No such route ...'
      return
    end
    puts 'Input train id ...'
    id = gets.chomp
    if not @trains.key?(id.to_sym)
      puts 'No such train ...'
      return
    end
    @trains[id.to_sym].set_route(@routes[name.to_sym])
  end

  def add_wagon_to_train
    puts 'Input train id ...'
    id = gets.chomp
    if not @trains.key?(id.to_sym)
      puts 'No such train ...'
      return
    end

    if @trains[id.to_sym].type == :cargo
      wagon = CargoWagon.new
    else
      wagon = PassengerWagon.new
    end
    @trains[id.to_sym].add_wagon(wagon)
  end

  def delete_wagon_from_train
    puts 'Input train id ...'
    id = gets.chomp
    if not @trains.key?(id.to_sym)
      puts 'No such train ...'
      return
    end

    @trains[id.to_sym].delete_wagon()
  end

  def move_train
    puts 'Input train id ...'
    id = gets.chomp
    if not @trains.key?(id.to_sym)
      puts 'No such train ...'
      return
    end

    if  @trains[id.to_sym].route.nil?
      puts 'No route for this train'
      return
    end

    train_cli = HighLine.new
    train_cli.choose do |menu|
      menu.prompt = 'Choose train option.'
      menu.choice('Move forward', text: 'Move') {@trains[id.to_sym].move_forward}
      menu.choice('Move back', text: 'Move') {@trains[id.to_sym].move_back}
    end
  end

  def show_stations(stations)
    puts stations.inspect
    #puts stations.map{|station_name, station| "#{station_name} : #{station.get_trains}"}
  end

  def show_trains
    puts @trains.to_s
  end

end

Main.new.start
