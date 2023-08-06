require "test_helper"

class CinemaTest < ActiveSupport::TestCase
  
  def setup
    @cinema = Cinema.new(name: "Example Cinema", location: "Somewhere", seats: 1)
  end
  
  test "should be valid" do
    assert @cinema.valid?
  end

  test "name should be present" do
    @cinema.name = " "
    assert_not @cinema.valid?
  end    

  test "location should be present" do
    @cinema.location = " "
    assert_not @cinema.valid?
  end

  test "should have 1-10 seats" do
    @cinema.seats = 0
    assert_not @cinema.valid?
    @cinema.seats = 11
    assert_not @cinema.valid?
    (1..10).each do |i|
      @cinema.seats = i
      assert @cinema.valid?
    end
  end
end
