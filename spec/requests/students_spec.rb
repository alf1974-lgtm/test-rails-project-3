require "rails_helper"

RSpec.describe "GET /api/v1/students/:id", type: :request do
  let(:student) { create(:user, :student, first_name: "Alice", last_name: "Smith", email: "alice@test.com") }
  let(:teacher) { create(:user, :teacher) }

  describe "GET /api/v1/students/:id" do
    it "returns the student's profile" do
      get "/api/v1/students/#{student.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(student.id)
      expect(json["full_name"]).to eq("Alice Smith")
      expect(json["email"]).to eq("alice@test.com")
      expect(json["role"]).to eq("student")
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
    let(:dept)     { create(:department) }
    let(:course1)  { create(:course, department: dept) }
    let(:course2)  { create(:course, department: dept) }
    let(:semester) { create(:semester) }
    let(:cs1)      { create(:class_session, course: course1, semester: semester, teacher: teacher) }
    let(:cs2)      { create(:class_session, course: course2, semester: semester, teacher: teacher) }

    before do
      create(:enrollment, class_session: cs1, student: student, grade: "A")
      create(:enrollment, class_session: cs2, student: student, grade: nil)
    end

    it "returns all enrollments for the student" do
      get "/api/v1/students/#{student.id}/courses"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
    end

    it "includes course, semester, teacher, and grade info" do
      get "/api/v1/students/#{student.id}/courses"

      json = JSON.parse(response.body)
      first = json.find { |e| e["grade"] == "A" }
      expect(first).not_to be_nil
      expect(first["class_session"]["course"]["id"]).to eq(course1.id)
      expect(first["class_session"]["semester"]["name"]).to eq(semester.name)
      expect(first["class_session"]["teacher"]["id"]).to eq(teacher.id)
    end

    it "returns an empty array when the student has no enrollments" do
      other_student = create(:user, :student)
      get "/api/v1/students/#{other_student.id}/courses"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end
  end
end
