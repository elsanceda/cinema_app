require "test_helper"

class MovieTest < ActiveSupport::TestCase

  def setup
    @movie = Movie.new(title: "Example Movie", synopsis: "Example Synopsis")
  end
  
  test "should be valid" do
    assert @movie.valid?
  end

  test "title should be present" do
    @movie.title = " "
    assert_not @movie.valid?
  end    

  test "synopsis should be present" do
    @movie.synopsis = " "
    assert_not @movie.valid?
  end
end
