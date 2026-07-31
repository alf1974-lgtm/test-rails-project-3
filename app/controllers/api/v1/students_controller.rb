module Api
  module V1
    class StudentsController < ApplicationController
      before_action :set_student

      # GET /api/v1/students/:id
      # Returns the student's basic info
      def show
        render json: student_json(@student)
      end

      # GET /api/v1/students/:id/courses
      # Returns all class sessions (with course, semester, teacher, grade) for the student
      def courses
        enrollments = @student.enrollments
                               .includes(class_session: [:course, :semester, :teacher])
                               .order("semesters.name, courses.name")

        render json: enrollments.map { |e| enrollment_json(e) }
      end

      private

      def set_student
        @student = User.students.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Student not found" }, status: :not_found
      end

      def student_json(user)
        {
          id:    user.id,
          name:  user.name,
          email: user.email,
          role:  user.role
        }
      end

      def enrollment_json(enrollment)
        cs = enrollment.class_session
        {
          class_session_id: cs.id,
          course: {
            id:         cs.course.id,
            name:       cs.course.name,
            code:       cs.course.code,
            department: cs.course.department.name
          },
          semester: {
            id:         cs.semester.id,
            name:       cs.semester.name,
            start_date: cs.semester.start_date,
            end_date:   cs.semester.end_date
          },
          teacher: {
            id:   cs.teacher.id,
            name: cs.teacher.name
          },
          grade: enrollment.grade
        }
      end
    end
  end
end
