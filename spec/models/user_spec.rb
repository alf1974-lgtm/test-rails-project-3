require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = build(:user, :student)
      expect(user).to be_valid
    end

    it "requires first_name" do
      user = build(:user, first_name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "requires last_name" do
      user = build(:user, last_name: nil)
      expect(user).not_to be_valid
    end

    it "requires a unique email" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "requires a valid email format" do
      user = build(:user, email: "not-an-email")
      expect(user).not_to be_valid
    end

    it "requires role to be student or teacher" do
      user = build(:user, role: "admin")
      expect(user).not_to be_valid
    end
  end

  describe "scopes" do
    it ".students returns only students" do
      student = create(:user, :student)
      teacher = create(:user, :teacher)
      expect(User.students).to include(student)
      expect(User.students).not_to include(teacher)
    end

    it ".teachers returns only teachers" do
      student = create(:user, :student)
      teacher = create(:user, :teacher)
      expect(User.teachers).to include(teacher)
      expect(User.teachers).not_to include(student)
    end
  end

  describe "#full_name" do
    it "returns first and last name" do
      user = build(:user, first_name: "Jane", last_name: "Doe")
      expect(user.full_name).to eq("Jane Doe")
    end
  end

  describe "#student? / #teacher?" do
    it "returns true for the correct role" do
      expect(build(:user, :student).student?).to be true
      expect(build(:user, :teacher).teacher?).to be true
    end
  end
end
