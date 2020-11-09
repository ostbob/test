# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :volume, :occupied_volume

  def initialize(volume)
    super(:cargo)
    @volume = volume
    @occupied_volume = 0
  end

  def occupy_volume(required_volume)
    @occupied_volume += required_volume if @volume >= @occupied_volume + required_volume
  end

  def free_volume
    @volume - @occupied_volume
  end
end
