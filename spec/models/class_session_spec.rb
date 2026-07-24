require 'rails_helper'

RSpec.describe ClassSession, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:course_id) }
    it { is_expected.to validate_presence_of(:semester_id) }
    it { is_expected.to validate_presence_of(:teacher_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:course) }
    it { is_expected.to belong_to(:semester) }
    it { is_expected.to belong_to(:teacher).class_name('User') }
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
    it { is_expected.to have_many(:students).through(:enrollments).source(:user) }
  end

  describe 'validations' do
    it 'validates that teacher is a teacher' do
      student = create(:user, :student)
      class_session = build(:class_session, teacher: student)
      expect(class_session).not_to be_valid
      expect(class_session.errors[:teacher_id]).to include("must be a teacher")
    end

    it 'allows a teacher to be assigned' do
      teacher = create(:user, :teacher)
      class_session = build(:class_session, teacher: teacher)
      expect(class_session).to be_valid
    end
  end
end
