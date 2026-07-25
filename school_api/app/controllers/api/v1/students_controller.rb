module Api
  module V1
    # GET /api/v1/students/:id        — student profile
    # GET /api/v1/students/:id/courses — courses the student is enrolled in
    class StudentsController < ApplicationController
      before_action :set_student

      # GET /api/v1/students/:id
      def show
        render json: student_json(@student)
      end

      # GET /api/v1/students/:id/courses
      def courses
        enrollments = @student.enrollments
                               .includes(class_session: [:course, :semester, :teacher])
                               .order("semesters.start_date DESC")

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
          id:         user.id,
          first_name: user.first_name,
          last_name:  user.last_name,
          full_name:  user.full_name,
          email:      user.email,
          role:       user.role
        }
      end

      def enrollment_json(enrollment)
        cs      = enrollment.class_session
        course  = cs.course
        sem     = cs.semester
        teacher = cs.teacher

        {
          enrollment_id:     enrollment.id,
          grade:             enrollment.grade,
          class_session: {
            id:       cs.id,
            room:     cs.room,
            schedule: cs.schedule,
            course: {
              id:          course.id,
              code:        course.code,
              name:        course.name,
              credits:     course.credits,
              department:  course.department&.name
            },
            semester: {
              id:         sem.id,
              name:       sem.name,
              start_date: sem.start_date,
              end_date:   sem.end_date
            },
            teacher: {
              id:        teacher.id,
              full_name: teacher.full_name,
              email:     teacher.email
            }
          }
        }
      end
    end
  end
end
