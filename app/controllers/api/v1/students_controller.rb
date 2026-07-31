module Api
  module V1
    # GET /api/v1/students/:id
    # GET /api/v1/students/:id/courses
    class StudentsController < ApplicationController
      before_action :set_student

      # GET /api/v1/students/:id
      # Returns the student's profile information.
      def show
        render json: student_json(@student)
      end

      # GET /api/v1/students/:id/courses
      # Returns all class sessions the student is enrolled in,
      # grouped by semester, with grade info.
      def courses
        enrollments = @student.enrollments
                               .includes(class_session: [:course, :semester, :teacher])
                               .order("semesters.year DESC, semesters.term ASC")

        by_semester = enrollments.group_by { |e| e.class_session.semester }

        result = by_semester.map do |semester, semester_enrollments|
          {
            semester: {
              id:         semester.id,
              name:       semester.name,
              term:       semester.term,
              year:       semester.year,
              start_date: semester.start_date,
              end_date:   semester.end_date
            },
            enrollments: semester_enrollments.map { |e| enrollment_json(e) }
          }
        end

        render json: {
          student: student_json(@student),
          semesters: result
        }
      end

      private

      def set_student
        @student = User.find_by(id: params[:id], role: "student")
        render_not_found("Student") unless @student
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
        cs      = enrollment.class_session
        course  = cs.course
        teacher = cs.teacher

        {
          enrollment_id: enrollment.id,
          status:        enrollment.status,
          grade:         enrollment.grade,
          class_session: {
            id:       cs.id,
            room:     cs.room,
            schedule: cs.schedule,
            course: {
              id:          course.id,
              name:        course.name,
              code:        course.code,
              credits:     course.credits,
              description: course.description,
              department:  course.department.name
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
