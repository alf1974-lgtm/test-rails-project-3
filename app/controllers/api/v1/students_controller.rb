module Api
  module V1
    class StudentsController < ApplicationController
      before_action :set_student

      # GET /api/v1/students/:id
      # Returns the student's profile information
      def show
        render json: student_json(@student)
      end

      # GET /api/v1/students/:id/courses
      # Returns all class sessions (with course/semester/grade info) for the student
      def courses
        enrollments = @student.enrollments
                               .includes(class_session: [:course, :semester, :teacher])
                               .order("semesters.start_date DESC")

        render json: {
          student: { id: @student.id, name: @student.full_name },
          enrollments: enrollments.map { |e| enrollment_json(e) }
        }
      end

      private

      def set_student
        @student = User.students.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Student not found with id #{params[:id]}" }, status: :not_found
      end

      def student_json(student)
        {
          id:         student.id,
          first_name: student.first_name,
          last_name:  student.last_name,
          full_name:  student.full_name,
          email:      student.email,
          role:       student.role
        }
      end

      def enrollment_json(enrollment)
        cs = enrollment.class_session
        {
          enrollment_id:     enrollment.id,
          grade:             enrollment.grade,
          class_session: {
            id:       cs.id,
            room:     cs.room,
            schedule: cs.schedule,
            course: {
              id:          cs.course.id,
              name:        cs.course.name,
              code:        cs.course.code,
              description: cs.course.description,
              credits:     cs.course.credits
            },
            semester: {
              id:         cs.semester.id,
              name:       cs.semester.name,
              start_date: cs.semester.start_date,
              end_date:   cs.semester.end_date
            },
            teacher: {
              id:   cs.teacher.id,
              name: cs.teacher.full_name
            }
          }
        }
      end
    end
  end
end
