require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Reservation class" do
  before do
    @room = Hotel::Room.new(room_number: 1)
    @reservation = Hotel::Reservation.new(check_in: "2019-3-29", check_out: "2019-3-30", room: @room)
  end
  it "creates an instance of Reservation" do
    expect(@reservation).must_be_kind_of Hotel::Reservation
  end

  it "throws an argument error when an invalid date range is provided" do
    expect { Hotel::Reservation.new(check_in: "2019-3-30", check_out: "2019-3-29", room: @room) }.must_raise ArgumentError
    expect { Hotel::Reservation.new(check_in: "2019-3-30", check_out: "2019-3-30", room: @room) }.must_raise ArgumentError
  end

  describe "total_cost method" do
    before do
      @room = Hotel::Room.new(room_number: 1)
      @reservation = Hotel::Reservation.new(check_in: "2019-3-10", check_out: "2019-3-12", room: @room)
    end

    it "calculates the total cost of a reservation" do
      cost_per_night = @room.cost_per_night

      total_cost = @reservation.total_cost(@reservation.check_in, @reservation.check_out, cost_per_night)
      expect(total_cost).must_equal 400.00
    end
  end
end
