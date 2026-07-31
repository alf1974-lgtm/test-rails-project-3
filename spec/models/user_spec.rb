require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid student attributes" do
      user = User.new(
        first_name: "Alice",
        last_name: "Smith",
        email: "alice@student.edu",
        role: "student",
        student_id: "S9999"
      )
      expect(user).to be_valid
    end

    it "is valid with valid teacher attributes" do
      user = User.new(
        first_name: "Bob",
        last_name: "Jones",
        email: "bob@school.edu",
        role: "teacher",
        employee_id: "T9999"
      )
      expect(user).to be_valid
    end

    it "is invalid without a first name" do
      user = User.new(last_name: "Smith", email: "x@x.com", role: "student")
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid with an unknown role" do
      user = User.new(first_name: "A", last_name: "B", email: "a@b.com", role: "admin")
      expect(user).not_to be_valid
    end

    it "is invalid with a duplicate email" do
      User.create!(first_name: "A", last_name: "B", email: "dup@test.com", role: "student")
      user = User.new(first_name: "C", last_name: "D", email: "dup@test.com", role: "student")
      expect(user).not_to be_valid
    end
  end

  describe "#full_name" do
    it "returns first and last name joined" do
      user = User.new(first_name: "Alice", last_name: "Johnson")
      expect(user.full_name).to eq("Alice Johnson")
    end
  end

  describe "#student? / #teacher?" do
    it "returns true for the correct role" do
      expect(User.new(role: "student").student?).to be true
      expect(User.new(role: "teacher").teacher?).to be true
      expect(User.new(role: "student").teacher?).to be false
    end
  end

  describe "scopes" do
    before do
      User.create!(first_name: "S", last_name: "One", email: "s1@x.com", role: "student")
      User.create!(first_name: "T", last_name: "One", email: "t1@x.com", role: "teacher")
    end

    it ".students returns only students" do
      expect(User.students.map(&:role).uniq).to eq(["student"])
    end

    it ".teachers returns only teachers" do
      expect(User.teachers.map(&:role).uniq).to eq(["teacher"])
    end
  end
end
