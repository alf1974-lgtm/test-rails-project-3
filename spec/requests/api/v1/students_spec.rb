require "rails_helper"

RSpec.describe "Api::V1::Students", type: :request do
  let(:student) { create(:user, :student, first_name: "Alice", last_name: "Smith", email: "alice@test.com") }
  let(:teacher) { create(:user, :teacher) }
  let(:dept)    { create(:department, name: "Math") }
  let(:course)  { create(:course, name: "Calculus I", code: "MAT101", department: dept) }
  let(:semester){ create(:semester, name: "Fall 2026", start_date: "2026-08-24", end_date: "2026-12-15") }
  let(:session) { create(:class_session, course: course, semester: semester, teacher: teacher) }

  describe "GET /api/v1/students/:id" do
    context "when the student exists" do
      it "returns the student profile" do
        get "/api/v1/students/#{student.id}"

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(student.id)
        expect(json["first_name"]).to eq("Alice")
        expect(json["last_name"]).to eq("Smith")
        expect(json["full_name"]).to eq("Alice Smith")
        expect(json["email"]).to eq("alice@test.com")
        expect(json["role"]).to eq("student")
      end
    end

    context "when the student does not exist" do
      it "returns 404" do
        get "/api/v1/students/99999"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("Student not found")
      end
    end

    context "when the id belongs to a teacher (not a student)" do
      it "returns 404" do
        get "/api/v1/students/#{teacher.id}"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /api/v1/students/:id/courses" do
    before do
      create(:enrollment, student: student, class_session: session, grade: "A")
    end

    it "returns the student and their enrollments" do
      get "/api/v1/students/#{student.id}/courses"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["student"]["id"]).to eq(student.id)
      expect(json["enrollments"].length).to eq(1)

      enrollment = json["enrollments"].first
      expect(enrollment["grade"]).to eq("A")
      expect(enrollment["class_session"]["course"]["name"]).to eq("Calculus I")
      expect(enrollment["class_session"]["course"]["code"]).to eq("MAT101")
      expect(enrollment["class_session"]["course"]["department"]).to eq("Math")
      expect(enrollment["class_session"]["semester"]["name"]).to eq("Fall 2026")
      expect(enrollment["class_session"]["teacher"]["full_name"]).to eq(teacher.full_name)
    end

    it "returns an empty enrollments array when not enrolled in anything" do
      get "/api/v1/students/#{student.id}/courses"
      # Remove the enrollment created in before block by using a fresh student
      fresh_student = create(:user, :student)
      get "/api/v1/students/#{fresh_student.id}/courses"

      json = JSON.parse(response.body)
      expect(json["enrollments"]).to eq([])
    end
  end
end
