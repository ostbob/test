class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train_list
    return @trains
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_passenger_train_list
    @trains.select {|train| train.type == :passenger}
  end

  def get_freight_train_list
    @trains.select {|train| train.type == :freight}
  end
end
