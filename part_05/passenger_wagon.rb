class PassengerWagon < Wagon
  attr_reader :seat_number, :free_seat_number

  def initialize(seat_number)
    super(:passenger)
    @seat_number = seat_number
    @free_seat_number = seat_number
  end

  def take_seat
    @free_seat_number -= 1 if @free_seat_number > 0
  end

  def get_taken_seats
    @seat_number - @free_seat_number
  end

  def get_free_seats
    @free_seat_number
  end

end
