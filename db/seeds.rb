# db/seeds.rb
# ============================================================
# School API — seed data
# ============================================================
puts "Seeding database..."

# ── Departments ──────────────────────────────────────────────
departments = {
  english:  Department.find_or_create_by!(name: "English"),
  math:     Department.find_or_create_by!(name: "Mathematics"),
  science:  Department.find_or_create_by!(name: "Science"),
  history:  Department.find_or_create_by!(name: "History"),
  cs:       Department.find_or_create_by!(name: "Computer Science")
}
puts "  #{Department.count} departments"

# ── Courses ───────────────────────────────────────────────────
courses_data = [
  { code: "ENG101", name: "Composition I",              credits: 3, department: :english,
    description: "Introduction to academic writing and rhetoric." },
  { code: "ENG201", name: "American Literature",        credits: 3, department: :english,
    description: "Survey of American literature from colonial times to the present." },
  { code: "MTH101", name: "Pre-Calculus",               credits: 3, department: :math,
    description: "Functions, trigonometry, and analytic geometry." },
  { code: "MTH201", name: "Calculus I",                 credits: 4, department: :math,
    description: "Limits, derivatives, and integrals of single-variable functions." },
  { code: "MTH301", name: "Linear Algebra",             credits: 3, department: :math,
    description: "Vectors, matrices, and linear transformations." },
  { code: "SCI101", name: "Biology I",                  credits: 4, department: :science,
    description: "Cell biology, genetics, and evolution." },
  { code: "SCI201", name: "Chemistry I",                credits: 4, department: :science,
    description: "Atomic structure, bonding, and chemical reactions." },
  { code: "HIS101", name: "World History I",            credits: 3, department: :history,
    description: "Ancient civilizations through the Renaissance." },
  { code: "HIS201", name: "US History",                 credits: 3, department: :history,
    description: "United States history from colonization to the present." },
  { code: "CS101",  name: "Intro to Programming",       credits: 3, department: :cs,
    description: "Fundamentals of programming using Python." },
  { code: "CS201",  name: "Data Structures",            credits: 3, department: :cs,
    description: "Arrays, linked lists, trees, graphs, and algorithm analysis." },
  { code: "CS301",  name: "Web Development",            credits: 3, department: :cs,
    description: "HTML, CSS, JavaScript, and modern web frameworks." }
]

courses = {}
courses_data.each do |data|
  dept = departments[data.delete(:department)]
  course = Course.find_or_create_by!(code: data[:code]) do |c|
    c.name        = data[:name]
    c.credits     = data[:credits]
    c.description = data[:description]
    c.department  = dept
  end
  courses[data[:code].to_sym] = course
end
puts "  #{Course.count} courses"

# ── Semesters ─────────────────────────────────────────────────
semesters = {
  fall2026:   Semester.find_or_create_by!(name: "Fall 2026") do |s|
                s.start_date = Date.new(2026, 8, 24)
                s.end_date   = Date.new(2026, 12, 18)
              end,
  spring2027: Semester.find_or_create_by!(name: "Spring 2027") do |s|
                s.start_date = Date.new(2027, 1, 11)
                s.end_date   = Date.new(2027, 5, 7)
              end
}
puts "  #{Semester.count} semesters"

# ── Teachers ──────────────────────────────────────────────────
teachers_data = [
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu" }
]

teachers = teachers_data.map do |data|
  User.find_or_create_by!(email: data[:email]) do |u|
    u.first_name = data[:first_name]
    u.last_name  = data[:last_name]
    u.role       = "teacher"
  end
end
puts "  #{User.teachers.count} teachers"

# ── Students ──────────────────────────────────────────────────
students_data = [
  { first_name: "Alice",   last_name: "Johnson",   email: "alice.johnson@students.edu" },
  { first_name: "Bob",     last_name: "Smith",     email: "bob.smith@students.edu" },
  { first_name: "Carol",   last_name: "Williams",  email: "carol.williams@students.edu" },
  { first_name: "David",   last_name: "Brown",     email: "david.brown@students.edu" },
  { first_name: "Eva",     last_name: "Davis",     email: "eva.davis@students.edu" },
  { first_name: "Frank",   last_name: "Miller",    email: "frank.miller@students.edu" },
  { first_name: "Grace",   last_name: "Wilson",    email: "grace.wilson@students.edu" },
  { first_name: "Henry",   last_name: "Moore",     email: "henry.moore@students.edu" },
  { first_name: "Iris",    last_name: "Taylor",    email: "iris.taylor@students.edu" },
  { first_name: "Jack",    last_name: "Anderson",  email: "jack.anderson@students.edu" },
  { first_name: "Karen",   last_name: "Thomas",    email: "karen.thomas@students.edu" },
  { first_name: "Leo",     last_name: "Jackson",   email: "leo.jackson@students.edu" }
]

students = students_data.map do |data|
  User.find_or_create_by!(email: data[:email]) do |u|
    u.first_name = data[:first_name]
    u.last_name  = data[:last_name]
    u.role       = "student"
  end
end
puts "  #{User.students.count} students"

# ── Class Sessions ────────────────────────────────────────────
# Helper: find_or_create a class session
def make_session(course:, semester:, teacher:, room:, schedule:)
  ClassSession.find_or_create_by!(
    course: course, semester: semester, teacher: teacher
  ) do |cs|
    cs.room     = room
    cs.schedule = schedule
  end
end

# Fall 2026 sessions
fall_sessions = [
  make_session(course: courses[:ENG101], semester: semesters[:fall2026],
               teacher: teachers[0], room: "HUM 101", schedule: "MWF 9:00-9:50"),
  make_session(course: courses[:MTH201], semester: semesters[:fall2026],
               teacher: teachers[1], room: "SCI 204", schedule: "MWF 10:00-10:50"),
  make_session(course: courses[:CS101],  semester: semesters[:fall2026],
               teacher: teachers[2], room: "CS 110",  schedule: "TTh 11:00-12:15"),
  make_session(course: courses[:HIS101], semester: semesters[:fall2026],
               teacher: teachers[3], room: "HUM 205", schedule: "TTh 14:00-15:15"),
  make_session(course: courses[:SCI101], semester: semesters[:fall2026],
               teacher: teachers[4], room: "SCI 101", schedule: "MWF 13:00-13:50")
]

# Spring 2027 sessions
spring_sessions = [
  make_session(course: courses[:ENG201], semester: semesters[:spring2027],
               teacher: teachers[0], room: "HUM 102", schedule: "MWF 9:00-9:50"),
  make_session(course: courses[:MTH301], semester: semesters[:spring2027],
               teacher: teachers[1], room: "SCI 205", schedule: "MWF 10:00-10:50"),
  make_session(course: courses[:CS201],  semester: semesters[:spring2027],
               teacher: teachers[2], room: "CS 111",  schedule: "TTh 11:00-12:15"),
  make_session(course: courses[:HIS201], semester: semesters[:spring2027],
               teacher: teachers[3], room: "HUM 206", schedule: "TTh 14:00-15:15"),
  make_session(course: courses[:SCI201], semester: semesters[:spring2027],
               teacher: teachers[4], room: "SCI 102", schedule: "MWF 13:00-13:50")
]

puts "  #{ClassSession.count} class sessions"

# ── Enrollments ───────────────────────────────────────────────
grades = %w[A A- B+ B B- C+ C]

# Enroll each student in 3 fall sessions and 3 spring sessions
all_sessions = fall_sessions + spring_sessions

students.each_with_index do |student, idx|
  # Pick 3 fall sessions (rotate by student index so they're spread out)
  chosen_fall   = fall_sessions.rotate(idx).first(3)
  chosen_spring = spring_sessions.rotate(idx + 2).first(3)

  chosen_fall.each_with_index do |cs, i|
    Enrollment.find_or_create_by!(class_session: cs, student: student) do |e|
      # Fall sessions are "done" — assign grades
      e.grade = grades[(idx + i) % grades.length]
    end
  end

  chosen_spring.each_with_index do |cs, i|
    Enrollment.find_or_create_by!(class_session: cs, student: student) do |e|
      # Spring sessions are in progress — some graded, some not
      e.grade = i.zero? ? nil : grades[(idx + i + 1) % grades.length]
    end
  end
end

puts "  #{Enrollment.count} enrollments"
puts "Done! 🎓"
