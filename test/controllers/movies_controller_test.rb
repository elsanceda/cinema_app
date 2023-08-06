require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @movie = movies(:action)
    @non_admin = users(:archer)
  end
  
  test "should redirect new when not logged in" do
    get new_movie_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Movie.count' do
      post movies_path, params: { movie: { title: "Example Movie",
                                           synopsis: "Lorem Ipsum" } }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_movie_path(@movie)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch movie_path(@movie), params: { movie: { title: @movie.title,
                                                 synopsis: @movie.synopsis } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Movie.count' do
      delete movie_path(@movie)
    end
    assert_not flash.empty?
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect new when non-admin" do
    log_in_as(@non_admin)
    get new_movie_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect create when non-admin" do
    log_in_as(@non_admin)
    assert_no_difference 'Movie.count' do
      post movies_path, params: { movie: { title: "Example Movie",
                                           synopsis: "Lorem Ipsum" } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when non-admin" do
    log_in_as(@non_admin)
    get edit_movie_path(@movie)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when non-admin" do
    log_in_as(@non_admin)
    patch movie_path(@movie), params: { movie: { title: @movie.title,
                                                 synopsis: @movie.synopsis } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when non-admin" do
    log_in_as(@non_admin)
    assert_no_difference 'Movie.count' do
      delete movie_path(@movie)
    end
    assert_not flash.empty?
    assert_response :see_other
    assert_redirected_to root_url
  end
end
