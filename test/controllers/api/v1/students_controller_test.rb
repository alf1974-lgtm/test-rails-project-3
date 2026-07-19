require "test_helper"

module Api
  module V1
    class StudentsControllerTest < ActionDispatch::IntegrationTest
      def setup
        # Teacher
        @teacher = User.create!(
          first_name: "Test", last_name: "Teacher",
          email: "test.teacher@school.edu", role: "teacher"
        )
        # Student
        @student = User.create!(
          first_name: "Test", last_name: "Student",
          email: "test.student@school.edu", role: "student"
        )
        # Supporting records
        @dept     = Department.create!(name: "Test Dept")
        @course   = Course.create!(name: "Test Course", code: "TST101", department: @dept)
        @semester = Semester.create!(name: "Test Sem", start_date: "2026-01-01", end_date: "2026-06-01")
        @session  = ClassSession.create!(course: @course, semester: @semester, teacher: @teacher,
                                         room: "100", schedule: "MWF 09:00")
        @enrollment = Enrollment.create!(class_session: @session, student: @student, grade: "A")
      end

      test "GET show returns student profile" do
        get "/api/v1/students/#{@student.id}"
        assert_response :success
        json = JSON.parse(response.body)
        assert_equal @student.id,         json["id"]
        assert_equal @student.first_name, json["first_name"]
        assert_equal "student",           json["role"]
      end

      test "GET show returns 404 for unknown student" do
        get "/api/v1/students/999999"
        assert_response :not_found
      end

      test "GET show returns 404 when id belongs to a teacher" do
        get "/api/v1/students/#{@teacher.id}"
        assert_response :not_found
      end

      test "GET courses returns enrolled class sessions" do
        get "/api/v1/students/#{@student.id}/courses"
        assert_response :success
        json = JSON.parse(response.body)
        assert_equal 1, json.length
        entry = json.first
        assert_equal "A",          entry["grade"]
        assert_equal "TST101",     entry["class_session"]["course"]["code"]
        assert_equal "Test Sem",   entry["class_session"]["semester"]["name"]
        assert_equal @teacher.full_name, entry["class_session"]["teacher"]["full_name"]
      end

      test "GET courses returns empty array for student with no enrollments" do
        bare_student = User.create!(first_name: "Bare", last_name: "Student",
                                    email: "bare@school.edu", role: "student")
        get "/api/v1/students/#{bare_student.id}/courses"
        assert_response :success
        assert_equal [], JSON.parse(response.body)
      end
    end
  end
end
