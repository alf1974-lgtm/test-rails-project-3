require "rails_helper"

RSpec.describe ClassSession, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      cs = build(:class_session)
      expect(cs).to be_valid
    end

    it "rejects a non-teacher as the teacher" do
      student = create(:user, :student)
      cs = build(:class_session, teacher: student)
      expect(cs).not_to be_valid
      expect(cs.errors[:teacher]).to include("must have the 'teacher' role")
    end
  end
end
