require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:class_session_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:class_session) }
  end

  describe 'uniqueness validation' do
    it 'prevents duplicate enrollments for the same student in the same class' do
      enrollment = create(:enrollment)
      duplicate = build(:enrollment, user: enrollment.user, class_session: enrollment.class_session)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:user_id]).to include("can only be enrolled once per class session")
    end
  end

  describe 'student validation' do
    it 'validates that user is a student' do
      teacher = create(:user, :teacher)
      enrollment = build(:enrollment, user: teacher)
      expect(enrollment).not_to be_valid
      expect(enrollment.errors[:user_id]).to include("must be a student")
    end

    it 'allows a student to be enrolled' do
      student = create(:user, :student)
      enrollment = build(:enrollment, user: student)
      expect(enrollment).to be_valid
    end
  end
end
