require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(full_name: "Example User", email: "user@example.com", 
                     mobile_number: "123456789", password: "Password1", 
                     password_confirmation: "Password1")
  end
  
  test "should be valid" do
    assert @user.valid?
  end

  test "full name should be present" do
    @user.full_name = " "
    assert_not @user.valid?
  end    

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "mobile number should be present" do
    @user.mobile_number = " "
    assert_not @user.valid?
  end

  test "full name should not be too long" do
    @user.full_name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end  

  test "mobile number should not be too long" do
    @user.mobile_number = "a" * 21
    assert_not @user.valid?
  end  

  test "email addresses should be unique" do
    duplicate_user = User.new(full_name: "Example User", email: "user@example.com", 
                              mobile_number: "987654321", password: "Password1", 
                              password_confirmation: "Password1")
    @user.save
    assert_not duplicate_user.valid?
  end

  test "mobile numbers should be unique" do
    duplicate_user = User.new(full_name: "Example User", email: "user@example1.com", 
                              mobile_number: "123456789", password: "Password1", 
                              password_confirmation: "Password1")
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
    foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
    
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

  test "password validation should accept valid passwords" do
    valid_passwords = %w[Password1 123IloveYou hey7arT$
    !supR3m0s Fl1n<h3z]
    valid_passwords.each do |valid_password|
      @user.password = @user.password_confirmation = valid_password
      assert @user.valid?, "#{valid_password.inspect} should be valid"
    end
  end

  test "password validation should reject invalid passwords" do
    invalid_passwords = %w[short nonumbers nouppercase1
    NOLOWERCASE1 12345678]
    invalid_passwords.each do |invalid_password|
      @user.password = @user.password_confirmation = invalid_password
      assert_not @user.valid?, "#{invalid_password.inspect} should be invalid"
    end
  end
end
