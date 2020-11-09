# frozen_string_literal: true

class CargoTrain < Train
  def initialize(id, speed = 0)
    super(id, :cargo, speed)
    validate!
  end
end
