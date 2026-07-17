class StudentsController < ApplicationController
  # GET /students/:id
  # Returns the student's profile information
  def show
    student = User.students.find(params[:id])
    render json: student_json(student)
  end

  # GET /students/:id/courses
  # Returns all class sessions (with course, semester, teacher, grade) for a student
  def courses
    student = User.students.find(params[:id])

    enrollments = student.enrollments
                         .includes(class_session: [ :course, :semester, :teacher ])
                         .order("semesters.start_date DESC, courses.name ASC")

    render json: {
      student: { id: student.id, name: student.full_name },
      courses: enrollments.map { |e| enrollment_json(e) }
    }
  end

  private

  def student_json(student)
    {
      id:         student.id,
      first_name: student.first_name,
      last_name:  student.last_name,
      full_name:  student.full_name,
      email:      student.email,
      role:       student.role,
      created_at: student.created_at
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
          name:        course.name,
          code:        course.code,
          description: course.description,
          credits:     course.credits,
          department:  course.department.name
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
