require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { full_name:  "",
                                         email: "user@invalid",
                                         mobile_number: "",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { full_name:  "Example User",
                                         email: "user@example.com",
                                         mobile_number: "123456789",
                                         password:              "Password1",
                                         password_confirmation: "Password1" } }
    end
    follow_redirect!
    assert_template 'dashboard/home'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
