require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:class_session) }
    it { is_expected.to belong_to(:student).class_name('User') }
  end

  describe 'validations' do
    let(:student)       { create(:student) }
    let(:class_session) { create(:class_session) }

    it 'is valid with a student, class_session, and no grade' do
      enrollment = build(:enrollment, student: student, class_session: class_session, grade: nil)
      expect(enrollment).to be_valid
    end

    it 'is valid with a grade of A' do
      enrollment = build(:enrollment, student: student, class_session: class_session, grade: 'A')
      expect(enrollment).to be_valid
    end

    it 'accepts all valid letter grades' do
      %w[A B C D F].each do |g|
        enrollment = build(:enrollment, student: student, class_session: class_session, grade: g)
        expect(enrollment).to be_valid, "expected grade #{g} to be valid"
      end
    end

    it 'rejects an invalid grade' do
      enrollment = build(:enrollment, student: student, class_session: class_session, grade: 'E')
      expect(enrollment).not_to be_valid
      expect(enrollment.errors[:grade]).to be_present
    end

    it 'rejects a numeric grade' do
      enrollment = build(:enrollment, student: student, class_session: class_session, grade: '95')
      expect(enrollment).not_to be_valid
    end

    it 'rejects a duplicate student enrollment in the same class session' do
      create(:enrollment, student: student, class_session: class_session)
      duplicate = build(:enrollment, student: student, class_session: class_session)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:class_session_id]).to be_present
    end

    it 'allows the same student in a different class session' do
      other_session = create(:class_session)
      create(:enrollment, student: student, class_session: class_session)
      second = build(:enrollment, student: student, class_session: other_session)
      expect(second).to be_valid
    end

    it 'rejects a teacher as the student' do
      teacher = create(:teacher)
      enrollment = build(:enrollment, student: teacher, class_session: class_session)
      expect(enrollment).not_to be_valid
      expect(enrollment.errors[:student]).to be_present
    end
  end

  describe 'grade edge cases' do
    it 'allows nil grade (grade not yet recorded)' do
      enrollment = create(:enrollment, grade: nil)
      expect(enrollment.grade).to be_nil
    end

    it 'can be updated from nil to a valid grade' do
      enrollment = create(:enrollment, grade: nil)
      enrollment.update!(grade: 'B')
      expect(enrollment.reload.grade).to eq('B')
    end
  end
end
