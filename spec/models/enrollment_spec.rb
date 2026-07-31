require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  let(:dept)    { Department.create!(name: "Test Dept", code: "TD") }
  let(:course)  { Course.create!(name: "Test Course", code: "TD101", credits: 3, department: dept) }
  let(:semester) do
    Semester.create!(name: "Test Fall", term: "Fall", year: 2025,
                     start_date: Date.new(2025, 8, 1), end_date: Date.new(2025, 12, 15))
  end
  let(:teacher) do
    User.create!(first_name: "Prof", last_name: "X", email: "prof@x.com",
                 role: "teacher", employee_id: "TX01")
  end
  let(:student) do
    User.create!(first_name: "Stu", last_name: "Y", email: "stu@x.com",
                 role: "student", student_id: "SY01")
  end
  let(:class_session) do
    ClassSession.create!(course: course, semester: semester, teacher: teacher)
  end

  it "is valid with a student and class session" do
    enrollment = Enrollment.new(student: student, class_session: class_session)
    expect(enrollment).to be_valid
  end

  it "is invalid if the user is a teacher (not a student)" do
    enrollment = Enrollment.new(student: teacher, class_session: class_session)
    expect(enrollment).not_to be_valid
    expect(enrollment.errors[:student]).to include("must have the student role")
  end

  it "is invalid with a duplicate student + class_session" do
    Enrollment.create!(student: student, class_session: class_session)
    dup = Enrollment.new(student: student, class_session: class_session)
    expect(dup).not_to be_valid
  end

  it "accepts valid grades" do
    enrollment = Enrollment.new(student: student, class_session: class_session, grade: "A")
    expect(enrollment).to be_valid
  end

  it "rejects invalid grades" do
    enrollment = Enrollment.new(student: student, class_session: class_session, grade: "Z")
    expect(enrollment).not_to be_valid
  end
end
