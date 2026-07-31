require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  let(:dept)    { Department.create!(name: "English", code: "ENG") }
  let(:course)  { Course.create!(name: "Composition I", code: "ENG101", credits: 3, department: dept) }
  let(:semester) do
    Semester.create!(name: "Fall 2026", term: "Fall", year: 2026,
                     start_date: Date.new(2026, 8, 24), end_date: Date.new(2026, 12, 15))
  end
  let(:teacher) do
    User.create!(first_name: "Margaret", last_name: "Atwood", email: "m.atwood@school.edu",
                 role: "teacher", employee_id: "T001")
  end
  let(:student) do
    User.create!(first_name: "Alice", last_name: "Johnson", email: "alice@student.edu",
                 role: "student", student_id: "S1001")
  end
  let(:class_session) do
    ClassSession.create!(course: course, semester: semester, teacher: teacher,
                         room: "Humanities 101", schedule: "MWF 9:00-9:50am")
  end

  before do
    Enrollment.create!(student: student, class_session: class_session,
                       grade: "A", status: "completed")
  end

  describe "GET /api/v1/students/:id" do
    it "returns the student's info" do
      get "/api/v1/students/#{student.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["first_name"]).to eq("Alice")
      expect(json["last_name"]).to eq("Johnson")
      expect(json["email"]).to eq("alice@student.edu")
      expect(json["role"]).to eq("student")
      expect(json["student_id"]).to eq("S1001")
    end

    it "returns 404 for a non-existent student" do
      get "/api/v1/students/99999"
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when the id belongs to a teacher (not a student)" do
      get "/api/v1/students/#{teacher.id}"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /api/v1/students/:id/courses" do
    it "returns the student's enrolled courses" do
      get "/api/v1/students/#{student.id}/courses"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["student"]["name"]).to eq("Alice Johnson")
      expect(json["courses"].length).to eq(1)

      course_entry = json["courses"].first
      expect(course_entry["grade"]).to eq("A")
      expect(course_entry["status"]).to eq("completed")
      expect(course_entry["class_session"]["course"]["code"]).to eq("ENG101")
      expect(course_entry["class_session"]["semester"]["name"]).to eq("Fall 2026")
      expect(course_entry["class_session"]["teacher"]["name"]).to eq("Margaret Atwood")
    end

    it "returns 404 for a non-existent student" do
      get "/api/v1/students/99999/courses"
      expect(response).to have_http_status(:not_found)
    end
  end
end
