require "test_helper"

class CinemasControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @cinema = cinemas(:grand)
    @non_admin = users(:archer)
  end
  
  test "should redirect new when not logged in" do
    get new_cinema_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Cinema.count' do
      post cinemas_path, params: { cinema: { name: "Example Cinema",
                                             location: "Example City",
                                             seats: 1 } }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_cinema_path(@cinema)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch cinema_path(@cinema), params: { cinema: { name: @cinema.name,
                                                    location: @cinema.location,
                                                    seats: @cinema.seats } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Cinema.count' do
      delete cinema_path(@cinema)
    end
    assert_not flash.empty?
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect new when non-admin" do
    log_in_as(@non_admin)
    get new_cinema_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect create when non-admin" do
    log_in_as(@non_admin)
    assert_no_difference 'Cinema.count' do
      post cinemas_path, params: { cinema: { name: "Example Cinema",
                                             location: "Example City",
                                             seats: 1 } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when non-admin" do
    log_in_as(@non_admin)
    get edit_cinema_path(@cinema)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when non-admin" do
    log_in_as(@non_admin)
    patch cinema_path(@cinema), params: { cinema: { name: @cinema.name,
                                                    location: @cinema.location,
                                                    seats: @cinema.seats } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when non-admin" do
    log_in_as(@non_admin)
    assert_no_difference 'Cinema.count' do
      delete cinema_path(@cinema)
    end
    assert_not flash.empty?
    assert_response :see_other
    assert_redirected_to root_url
  end
end
