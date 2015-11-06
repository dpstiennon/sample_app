require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password:"p@ssword", password_confirmation: "p@ssword")
  end

  test "should be valid" do
    assert @user.valid?
  end
  # test "the truth" do
  #   assert true
  # end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "      "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = 'a' * 300 + '@example.com'
    assert_not @user.valid?
  end

  test "email addresses should be email addresses" do
    valid_addresses = %w[valid@example.com dstiennon@ackmanndickenson.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address} should be a valid email"
    end
  end

  test "invalid email addresses should not work" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid? "#{address} should not be valid"
    end
  end

  test "should not accept duplicate emails" do
    duplicate_user = @user.dup
    duplicate_user.email = duplicate_user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test "password should be a minimum length" do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for  a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem Ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

end
