# Require gems

# Require relatives

module Hotel
  class Room
    attr_reader :room_number, :reservations, :cost_per_night

    def initialize(room_number:, reservations: nil, cost_per_night: 200.00)
      @room_number = room_number
      @reservations = reservations || []
      @cost_per_night = cost_per_night
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def is_available?(possible_check_in, possible_check_out)
      availability = true

      @reservations.each do |reservation|
        availability = !availability if reservation.check_in == possible_check_in
      end
      return availability
    end
  end
end
