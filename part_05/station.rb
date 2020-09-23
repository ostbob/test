class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  # Это public, потому что могут использоваться как интерфейс к объекту Station
  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_passenger_train_list
    @trains.select {|train| train.type == :passenger}
  end

  def get_cargo_train_list
    @trains.select {|train| train.type == :cargo}
  end

  def get_trains
    if @trains.length == 0
      return 'No trains'
    else
      trains_ids = []
      @trains.each do |train|
        trains_ids << train.id
      end

      return 'Trains ids: ' + trains_ids.join(', ')
    end
  end
end
