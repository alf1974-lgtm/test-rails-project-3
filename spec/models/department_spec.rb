require 'rails_helper'

RSpec.describe Department, type: :model do
  it "is valid with a name and code" do
    dept = Department.new(name: "Philosophy", code: "PHIL")
    expect(dept).to be_valid
  end

  it "is invalid without a name" do
    dept = Department.new(code: "PHIL")
    expect(dept).not_to be_valid
  end

  it "is invalid without a code" do
    dept = Department.new(name: "Philosophy")
    expect(dept).not_to be_valid
  end

  it "is invalid with a duplicate name" do
    Department.create!(name: "Art", code: "ART")
    dept = Department.new(name: "Art", code: "ART2")
    expect(dept).not_to be_valid
  end

  it "has many courses" do
    dept = Department.create!(name: "Music", code: "MUS")
    dept.courses.create!(name: "Music Theory", code: "MUS101", credits: 3)
    expect(dept.courses.count).to eq(1)
  end
end
