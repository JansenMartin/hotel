# Require gems
require "date"

# Require relatives
require_relative "room.rb"
require_relative "reservation.rb"

module Hotel
  class Manager
    attr_reader :rooms, :reservations

    def initialize
      @rooms = Room.generate_rooms(20)
      @reservations = []
    end

    def reserve_room(check_in, check_out, room_selection: nil)
      available_room_list = list_available_rooms(check_in, check_out)

      if available_room_list == []
        return available_room_list
      elsif room_selection != nil
        available_room = ""
        available_room_list.each do |room|
          available_room = room if room.room_number == room_selection
        end
        if available_room == ""
          raise ArgumentError, "Room ##{room_selection} is unavailable between #{check_in} and #{check_out}."
        end
      else
        available_room = available_room_list[0]
      end

      reservation_id = @reservations.length + 1
      reservation = Reservation.new_reservation(check_in, check_out, available_room, reservation_id)

      available_room.add_reservation(reservation)
      @reservations << reservation

      return reservation
    end

    def list_available_rooms(check_in, check_out)
      list = []
      booking_range = (Date.parse(check_in)..Date.parse(check_out))

      @rooms.each do |room|
        if room.is_available?(booking_range)
          list << room
        end
      end

      return list
    end

    def list_reservations_on(date)
      list = []
      date = Date.parse(date)

      @reservations.each do |reservation|
        check_in = reservation.check_in
        check_out = reservation.check_out

        if (check_in..check_out).include?(date)
          list << reservation
        end
      end

      return list
    end
  end
end
