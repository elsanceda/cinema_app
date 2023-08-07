require "test_helper"

class ShowingTest < ActiveSupport::TestCase
  
  def setup
    @cinema = cinemas(:grand)
    @movie = movies(:action)
    @showing = Showing.new(timeslot: 1320, cinema_id: @cinema.id, 
                           movie_id: @movie.id)
  end
  
  test "should be valid" do
    assert @showing.valid?
  end

  test "timeslot should be present" do
    @showing.timeslot = nil
    assert_not @showing.valid?
  end    

  test "cinema id should be present" do
    @showing.cinema_id = nil
    assert_not @showing.valid?
  end

  test "movie id should be present" do
    @showing.movie_id = nil
    assert_not @showing.valid?
  end

  test "should not have the same cinema and timeslot" do
    duplicate_showing = Showing.new(timeslot: 1320, cinema_id: @cinema.id,
                                    movie_id: 2)
    @showing.save
    assert_not duplicate_showing.valid?
  end
end
