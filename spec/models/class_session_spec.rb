require 'rails_helper'

RSpec.describe ClassSession, type: :model do
  let(:dept)    { Department.create!(name: "CS Dept", code: "CSD") }
  let(:course)  { Course.create!(name: "Algorithms", code: "CSD301", credits: 3, department: dept) }
  let(:semester) do
    Semester.create!(name: "Spring 2025", term: "Spring", year: 2025,
                     start_date: Date.new(2025, 1, 10), end_date: Date.new(2025, 5, 10))
  end
  let(:teacher) do
    User.create!(first_name: "Dr", last_name: "Smith", email: "dr.smith@school.edu",
                 role: "teacher", employee_id: "TS01")
  end
  let(:student) do
    User.create!(first_name: "Jane", last_name: "Doe", email: "jane@student.edu",
                 role: "student", student_id: "JD01")
  end

  it "is valid with course, semester, and teacher" do
    cs = ClassSession.new(course: course, semester: semester, teacher: teacher)
    expect(cs).to be_valid
  end

  it "is invalid if teacher is actually a student" do
    cs = ClassSession.new(course: course, semester: semester, teacher: student)
    expect(cs).not_to be_valid
    expect(cs.errors[:teacher]).to include("must have the teacher role")
  end

  it "can have multiple students via enrollments" do
    cs = ClassSession.create!(course: course, semester: semester, teacher: teacher)
    Enrollment.create!(student: student, class_session: cs)
    expect(cs.students).to include(student)
  end
end
