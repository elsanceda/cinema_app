require "test_helper"

class BookingTest < ActiveSupport::TestCase
  
  def setup
    @showing = showings(:action_show)
    @user = users(:archer)
    @booking = Booking.new(seat_number: 2, showing_id: @showing.id, 
                           user_id: @user.id)
  end
  
  test "should be valid" do
    assert @booking.valid?
  end

  test "seat number should be present" do
    @booking.seat_number = nil
    assert_not @booking.valid?
  end    

  test "showing id should be present" do
    @booking.showing_id = nil
    assert_not @booking.valid?
  end

  test "user id should be present" do
    @booking.user_id = nil
    assert_not @booking.valid?
  end

  test "should not have the same showing and seat number" do
    duplicate_booking = Booking.new(seat_number: 2, showing_id: @showing.id,
                                    user_id: 1)
    @booking.save
    assert_not duplicate_booking.valid?
  end
end
