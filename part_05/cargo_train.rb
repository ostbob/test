class CargoTrain < Train
  def initialize(id, speed=0)
    super(id, :cargo, speed)
  end

end
