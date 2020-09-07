require './Station'
require './Train'
require './Route'

station_1 = Station.new('first_staion')
station_2 = Station.new('2nd_station')
station_3 = Station.new('3rd_station')
station_4 = Station.new('4th_station')
station_5 = Station.new('5th_station')
station_6 = Station.new('6th_station')


train_1 = Train.new('first_train', :freight, 10)
train_2 = Train.new('second_train', :passenger, 15)
train_3 = Train.new('third_train', :passenger, 5)

route = Route.new(station_1, station_6)
route.add_station(station_2)
route.add_station(station_3)
route.add_station(station_4)
route.add_station(station_5)

train_1.set_route(route)
train_1.move_forward
train_1.move_forward

puts train_1.current_station.name
train_1.move_back
puts train_1.current_station.name

