require 'rails_helper'

RSpec.describe ClassSession, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:course) }
    it { is_expected.to belong_to(:semester) }
    it { is_expected.to belong_to(:teacher).class_name('User') }
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
    it { is_expected.to have_many(:students).through(:enrollments) }
  end

  describe 'validations' do
    let(:teacher)  { create(:teacher) }
    let(:course)   { create(:course) }
    let(:semester) { create(:semester) }

    it 'is valid with a course, semester, and teacher' do
      session = build(:class_session, course: course, semester: semester, teacher: teacher)
      expect(session).to be_valid
    end

    it 'rejects a duplicate course+semester+teacher combination' do
      create(:class_session, course: course, semester: semester, teacher: teacher)
      duplicate = build(:class_session, course: course, semester: semester, teacher: teacher)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:course_id]).to be_present
    end

    it 'allows the same course in a different semester' do
      other_semester = create(:semester, season: 'Spring', name: 'Spring 2099', year: 2099)
      create(:class_session, course: course, semester: semester, teacher: teacher)
      session2 = build(:class_session, course: course, semester: other_semester, teacher: teacher)
      expect(session2).to be_valid
    end

    it 'rejects a non-teacher as the teacher' do
      student = create(:student)
      session = build(:class_session, teacher: student)
      expect(session).not_to be_valid
      expect(session.errors[:teacher]).to be_present
    end
  end

  describe '#full?' do
    it 'returns false when enrollment count is below the cap' do
      session = create(:class_session)
      expect(session.full?).to be false
    end

    it 'returns true when enrollment count reaches the cap' do
      session = create(:class_session)
      ClassSession::MAX_STUDENTS.times do
        student = create(:student)
        create(:enrollment, class_session: session, student: student)
      end
      expect(session.full?).to be true
    end
  end

  describe 'class session with no enrollments' do
    it 'has zero students' do
      session = create(:class_session)
      expect(session.students).to be_empty
    end

    it 'has zero enrollments' do
      session = create(:class_session)
      expect(session.enrollments).to be_empty
    end
  end
end
