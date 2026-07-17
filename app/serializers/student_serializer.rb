class StudentSerializer
  def initialize(student)
    @student = student
  end

  def as_json
    {
      id: @student.id,
      first_name: @student.first_name,
      last_name: @student.last_name,
      full_name: @student.full_name,
      email: @student.email,
      role: @student.role,
      grade: @student.grade,
      advisor: advisor_json
    }
  end

  private

  def advisor_json
    return nil if @student.advisor.nil?

    {
      id: @student.advisor.id,
      full_name: @student.advisor.full_name,
      email: @student.advisor.email
    }
  end
end
