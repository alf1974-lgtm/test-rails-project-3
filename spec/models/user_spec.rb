require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:advisor).class_name('User').optional }
    it { is_expected.to have_many(:advisees).class_name('User').dependent(:nullify) }
    it { is_expected.to have_many(:taught_sessions).class_name('ClassSession').dependent(:destroy) }
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
    it { is_expected.to have_many(:class_sessions).through(:enrollments) }
  end

  describe 'validations' do
    subject { build(:student) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_inclusion_of(:role).in_array(%w[student teacher]) }

    it 'is invalid with a malformed email' do
      user = build(:student, email: 'not-an-email')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it 'is valid with a properly formatted email' do
      user = build(:student, email: 'valid@example.com')
      expect(user).to be_valid
    end
  end

  describe 'grade validations' do
    it 'allows grades 9-12 for students' do
      [9, 10, 11, 12].each do |g|
        expect(build(:student, grade: g)).to be_valid
      end
    end

    it 'rejects invalid grade values for students' do
      user = build(:student, grade: 8)
      expect(user).not_to be_valid
      expect(user.errors[:grade]).to be_present
    end

    it 'allows nil grade for students' do
      user = build(:student, grade: nil)
      expect(user).to be_valid
    end

    it 'rejects a grade set on a teacher' do
      user = build(:teacher, grade: 10)
      expect(user).not_to be_valid
      expect(user.errors[:grade]).to be_present
    end

    it 'allows nil grade for teachers' do
      user = build(:teacher, grade: nil)
      expect(user).to be_valid
    end
  end

  describe 'advisor validation' do
    it 'allows a teacher as advisor' do
      teacher = create(:teacher)
      student = build(:student, advisor: teacher)
      expect(student).to be_valid
    end

    it 'rejects a student as advisor' do
      other_student = create(:student)
      student = build(:student, advisor: other_student)
      expect(student).not_to be_valid
      expect(student.errors[:advisor]).to be_present
    end

    it 'allows no advisor (nil)' do
      student = build(:student, advisor: nil)
      expect(student).to be_valid
    end
  end

  describe '#full_name' do
    it 'returns first and last name concatenated' do
      user = build(:student, first_name: 'Jane', last_name: 'Doe')
      expect(user.full_name).to eq('Jane Doe')
    end
  end

  describe '#student?' do
    it 'returns true for students' do
      expect(build(:student).student?).to be true
    end

    it 'returns false for teachers' do
      expect(build(:teacher).student?).to be false
    end
  end

  describe '#teacher?' do
    it 'returns true for teachers' do
      expect(build(:teacher).teacher?).to be true
    end

    it 'returns false for students' do
      expect(build(:student).teacher?).to be false
    end
  end
end
