require "test_helper"

class DepartmentTest < ActiveSupport::TestCase
  test "valid department" do
    dept = Department.new(name: "Philosophy")
    assert dept.valid?
  end

  test "requires name" do
    dept = Department.new
    assert_not dept.valid?
    assert_includes dept.errors[:name], "can't be blank"
  end
end
