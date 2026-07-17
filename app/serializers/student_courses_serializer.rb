class StudentCoursesSerializer
  def initialize(student)
    @student = student
  end

  def as_json
    {
      student_id: @student.id,
      full_name: @student.full_name,
      enrollments: enrollment_data
    }
  end

  private

  def enrollment_data
    @student.enrollments
            .includes(class_session: %i[course semester teacher])
            .order('semesters.year DESC, semesters.season ASC')
            .map { |enrollment| serialize_enrollment(enrollment) }
  end

  def serialize_enrollment(enrollment)
    session = enrollment.class_session
    {
      enrollment_id: enrollment.id,
      grade: enrollment.grade,
      class_session: build_session_json(session)
    }
  end

  def build_session_json(session)
    {
      id: session.id,
      course: build_course_json(session.course),
      semester: build_semester_json(session.semester),
      teacher: { id: session.teacher.id, full_name: session.teacher.full_name }
    }
  end

  def build_course_json(course)
    {
      id: course.id,
      name: course.name,
      code: course.code,
      department: course.department.name
    }
  end

  def build_semester_json(semester)
    {
      id: semester.id,
      name: semester.name,
      season: semester.season,
      year: semester.year
    }
  end
end
