module Api
  module V1
    class StudentsController < ApplicationController
      # GET /api/v1/students/:id
      def show
        student = User.students.find(params[:id])
        render json: student_json(student)
      end

      # GET /api/v1/students/:id/courses
      def courses
        student = User.students.find(params[:id])

        enrollments = student.enrollments
                             .includes(class_session: [:course, :semester, :teacher])
                             .order("semesters.year DESC, semesters.term ASC")

        render json: {
          student: { id: student.id, name: student.full_name },
          courses: enrollments.map { |e| enrollment_json(e) }
        }
      end

      private

      def student_json(student)
        {
          id: student.id,
          first_name: student.first_name,
          last_name: student.last_name,
          full_name: student.full_name,
          email: student.email,
          role: student.role,
          student_id: student.student_id
        }
      end

      def enrollment_json(enrollment)
        cs = enrollment.class_session
        {
          enrollment_id: enrollment.id,
          status: enrollment.status,
          grade: enrollment.grade,
          class_session: {
            id: cs.id,
            room: cs.room,
            schedule: cs.schedule,
            course: {
              id: cs.course.id,
              code: cs.course.code,
              name: cs.course.name,
              credits: cs.course.credits,
              department: cs.course.department.name
            },
            semester: {
              id: cs.semester.id,
              name: cs.semester.name,
              term: cs.semester.term,
              year: cs.semester.year
            },
            teacher: {
              id: cs.teacher.id,
              name: cs.teacher.full_name,
              email: cs.teacher.email
            }
          }
        }
      end
    end
  end
end
