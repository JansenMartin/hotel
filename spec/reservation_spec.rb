require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Reservation class" do
  before do
    @check_in = Date.today.to_s
    @check_out = (Date.today + 2).to_s
    @room = Hotel::Room.new(room_number: 1)
    @reservation = Hotel::Reservation.new(check_in: @check_in, check_out: @check_out, room: @room)
  end
  it "creates an instance of Reservation" do
    expect(@reservation).must_be_kind_of Hotel::Reservation
  end

  it "throws an argument error when an invalid date range is provided" do
    expect { Hotel::Reservation.new(check_in: "2019-3-30", check_out: "2019-3-29", room: @room) }.must_raise ArgumentError
    expect { Hotel::Reservation.new(check_in: "2019-3-30", check_out: "2019-3-30", room: @room) }.must_raise ArgumentError
    expect { Hotel::Reservation.new(check_in: "1919-5-20", check_out: "2019-5-30", room: @room) }.must_raise ArgumentError
    expect { Hotel::Reservation.new(check_in: (Date.today - 1).to_s, check_out: (Date.today + 1).to_s, room: @room) }.must_raise ArgumentError
  end

  it "throws an argument error when an invalid date format is provided" do
    expect { Hotel::Reservation.new(check_in: "03-20-2019", check_out: "03-22-2019", room: @room) }.must_raise ArgumentError
    expect { Hotel::Reservation.new(check_in: "2019-20-3", check_out: "2019-20-3", room: @room) }.must_raise ArgumentError
  end

  it "uniformly formats dates" do
    check_in = "2100/08/07"
    check_out = "2100/08/08"

    reservation = Hotel::Reservation.new(check_in: "2100/08/07", check_out: "2100/08/08", room: @room)
    expect(reservation.check_in.to_s).must_equal "2100-08-07"
  end

  it "calculates the total cost for each reservation" do
    total_cost = @reservation.total_cost(@reservation.check_in, @reservation.check_out, @room.cost_per_night)
    expect(total_cost).must_equal 400.00
  end

  describe "number_of_nights method" do
    before do
      @reservation = Hotel::Reservation.new(check_in: @check_in, check_out: @check_out, room: @room)
      @number_of_nights = @reservation.number_of_nights(@reservation.check_in, @reservation.check_out)
    end
    it "calculates the number of nights a reservation lasts for" do
      expect(@number_of_nights).must_equal 2
    end
  end

  describe "total_cost method" do
    before do
      @room = Hotel::Room.new(room_number: 1)
      @reservation = Hotel::Reservation.new(check_in: @check_in, check_out: @check_out, room: @room)
    end

    it "calculates the total cost of a reservation" do
      cost_per_night = @room.cost_per_night

      total_cost = @reservation.total_cost(@reservation.check_in, @reservation.check_out, cost_per_night)
      expect(total_cost).must_equal 400.00
    end
  end
end
