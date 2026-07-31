require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid student" do
    user = User.new(first_name: "Jane", last_name: "Doe", email: "jane@test.edu", role: "student")
    assert user.valid?
  end

  test "valid teacher" do
    user = User.new(first_name: "Prof", last_name: "Smith", email: "prof@test.edu", role: "teacher")
    assert user.valid?
  end

  test "invalid role" do
    user = User.new(first_name: "X", last_name: "Y", email: "xy@test.edu", role: "admin")
    assert_not user.valid?
  end

  test "full_name" do
    user = User.new(first_name: "Jane", last_name: "Doe")
    assert_equal "Jane Doe", user.full_name
  end
end
