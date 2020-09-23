class PassengerTrain < Train
  def initialize(id, speed=0)
    super(id, :passenger, speed)
  end
end
