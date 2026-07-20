require "rails_helper"

RSpec.describe Enrollment, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      enrollment = build(:enrollment)
      expect(enrollment).to be_valid
    end

    it "prevents duplicate enrollment in the same class session" do
      student = create(:user, :student)
      cs      = create(:class_session)
      create(:enrollment, class_session: cs, student: student)
      dup = build(:enrollment, class_session: cs, student: student)
      expect(dup).not_to be_valid
      expect(dup.errors[:student_id]).to be_present
    end

    it "rejects a non-student user as the student" do
      teacher = create(:user, :teacher)
      cs      = create(:class_session)
      enrollment = build(:enrollment, class_session: cs, student: teacher)
      expect(enrollment).not_to be_valid
      expect(enrollment.errors[:student]).to include("must have the 'student' role")
    end

    it "accepts valid letter grades" do
      enrollment = build(:enrollment, grade: "A")
      expect(enrollment).to be_valid
    end

    it "rejects invalid grades" do
      enrollment = build(:enrollment, grade: "Z")
      expect(enrollment).not_to be_valid
    end

    it "allows nil grade (not yet graded)" do
      enrollment = build(:enrollment, grade: nil)
      expect(enrollment).to be_valid
    end
  end
end
