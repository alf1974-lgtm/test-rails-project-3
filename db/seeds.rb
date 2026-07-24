# Clear existing data
Enrollment.delete_all
ClassSession.delete_all
Course.delete_all
Department.delete_all
Semester.delete_all
User.delete_all

# Create departments
english_dept = Department.create!(name: "English")
math_dept = Department.create!(name: "Math")
science_dept = Department.create!(name: "Science")
history_dept = Department.create!(name: "History")

puts "Created 4 departments"

# Create courses
english_101 = Course.create!(name: "English Composition", code: "ENG101", department: english_dept)
english_201 = Course.create!(name: "Literature", code: "ENG201", department: english_dept)
math_101 = Course.create!(name: "Algebra", code: "MATH101", department: math_dept)
math_201 = Course.create!(name: "Calculus", code: "MATH201", department: math_dept)
science_101 = Course.create!(name: "Biology", code: "SCI101", department: science_dept)
history_101 = Course.create!(name: "World History", code: "HIST101", department: history_dept)

puts "Created 6 courses"

# Create semesters
fall_2026 = Semester.create!(name: "Fall 2026")
spring_2027 = Semester.create!(name: "Spring 2027")

puts "Created 2 semesters"

# Create teachers
teacher1 = User.create!(name: "Dr. Smith", email: "smith@school.edu", role: :teacher)
teacher2 = User.create!(name: "Prof. Johnson", email: "johnson@school.edu", role: :teacher)
teacher3 = User.create!(name: "Ms. Williams", email: "williams@school.edu", role: :teacher)

puts "Created 3 teachers"

# Create students
students = []
10.times do |i|
  students << User.create!(
    name: "Student #{i + 1}",
    email: "student#{i + 1}@school.edu",
    role: :student
  )
end

puts "Created 10 students"

# Create class sessions
class_session_1 = ClassSession.create!(course: english_101, semester: fall_2026, teacher: teacher1)
class_session_2 = ClassSession.create!(course: math_101, semester: fall_2026, teacher: teacher2)
class_session_3 = ClassSession.create!(course: science_101, semester: fall_2026, teacher: teacher3)
class_session_4 = ClassSession.create!(course: english_201, semester: spring_2027, teacher: teacher1)
class_session_5 = ClassSession.create!(course: math_201, semester: spring_2027, teacher: teacher2)

puts "Created 5 class sessions"

# Create enrollments with grades
[class_session_1, class_session_2, class_session_3].each do |session|
  students[0..4].each do |student|
    Enrollment.create!(
      user: student,
      class_session: session,
      grade: rand(60..100)
    )
  end
end

[class_session_4, class_session_5].each do |session|
  students[5..9].each do |student|
    Enrollment.create!(
      user: student,
      class_session: session,
      grade: rand(60..100)
    )
  end
end

puts "Created enrollments with grades"
puts "Seed data created successfully!"
