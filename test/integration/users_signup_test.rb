require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "signup with invalid password fails" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "user@invalid.com",
                               password: "foo",
                               password_confirmation: "bar" }
    end
  end

  test "signup with valid data succeeds" do
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Example User",
                                            email: "user@example.com",
                                            password: 'p@ssword',
                                            password_confirmation: 'p@ssword' }
    end
    assert_template 'users/show'

  end
end

