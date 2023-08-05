require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Cinema Booking App"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end
end
