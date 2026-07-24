require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
    it { is_expected.to have_many(:class_sessions_as_teacher).dependent(:destroy) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role).with_values(student: 0, teacher: 1) }
  end

  describe '#student?' do
    it 'returns true for student role' do
      user = build(:user, :student)
      expect(user.student?).to be true
    end

    it 'returns false for teacher role' do
      user = build(:user, :teacher)
      expect(user.student?).to be false
    end
  end

  describe '#teacher?' do
    it 'returns true for teacher role' do
      user = build(:user, :teacher)
      expect(user.teacher?).to be true
    end

    it 'returns false for student role' do
      user = build(:user, :student)
      expect(user.teacher?).to be false
    end
  end
end
