# db/seeds.rb
# ============================================================
# School API — seed data
# ============================================================
puts "Seeding database..."

# ── Departments ──────────────────────────────────────────────
departments = {}
[
  "English",
  "Mathematics",
  "Science",
  "History",
  "Computer Science",
  "Physical Education"
].each do |name|
  departments[name] = Department.find_or_create_by!(name: name)
end
puts "  #{Department.count} departments"

# ── Courses ───────────────────────────────────────────────────
courses_data = [
  { code: "ENG101", name: "Composition I",              dept: "English",            credits: 3, description: "Introduction to academic writing." },
  { code: "ENG201", name: "American Literature",        dept: "English",            credits: 3, description: "Survey of American literature from colonial times to present." },
  { code: "MAT101", name: "Pre-Calculus",               dept: "Mathematics",        credits: 4, description: "Functions, trigonometry, and analytic geometry." },
  { code: "MAT201", name: "Calculus I",                 dept: "Mathematics",        credits: 4, description: "Limits, derivatives, and integrals." },
  { code: "MAT301", name: "Linear Algebra",             dept: "Mathematics",        credits: 3, description: "Vectors, matrices, and linear transformations." },
  { code: "SCI101", name: "Biology I",                  dept: "Science",            credits: 4, description: "Cell biology, genetics, and evolution." },
  { code: "SCI201", name: "Chemistry I",                dept: "Science",            credits: 4, description: "Atomic structure, bonding, and reactions." },
  { code: "SCI301", name: "Physics I",                  dept: "Science",            credits: 4, description: "Mechanics, thermodynamics, and waves." },
  { code: "HIS101", name: "World History I",            dept: "History",            credits: 3, description: "Ancient civilizations through the Middle Ages." },
  { code: "HIS201", name: "US History",                 dept: "History",            credits: 3, description: "American history from colonization to the present." },
  { code: "CS101",  name: "Intro to Programming",       dept: "Computer Science",   credits: 3, description: "Programming fundamentals using Python." },
  { code: "CS201",  name: "Data Structures",            dept: "Computer Science",   credits: 3, description: "Arrays, linked lists, trees, and graphs." },
  { code: "PE101",  name: "Fitness & Wellness",         dept: "Physical Education", credits: 1, description: "Physical fitness principles and activities." },
]

courses = {}
courses_data.each do |c|
  courses[c[:code]] = Course.find_or_create_by!(code: c[:code]) do |course|
    course.name        = c[:name]
    course.description = c[:description]
    course.credits     = c[:credits]
    course.department  = departments[c[:dept]]
  end
end
puts "  #{Course.count} courses"

# ── Semesters ─────────────────────────────────────────────────
fall2026 = Semester.find_or_create_by!(name: "Fall 2026") do |s|
  s.start_date = Date.new(2026, 8, 24)
  s.end_date   = Date.new(2026, 12, 18)
end

spring2027 = Semester.find_or_create_by!(name: "Spring 2027") do |s|
  s.start_date = Date.new(2027, 1, 11)
  s.end_date   = Date.new(2027, 5, 7)
end
puts "  #{Semester.count} semesters"

# ── Teachers ──────────────────────────────────────────────────
teachers_data = [
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu" },
  { first_name: "Grace",    last_name: "Hopper",    email: "g.hopper@school.edu" },
]

teachers = teachers_data.map do |t|
  User.find_or_create_by!(email: t[:email]) do |u|
    u.first_name = t[:first_name]
    u.last_name  = t[:last_name]
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
  { first_name: "Leo",     last_name: "Jackson",   email: "leo.jackson@students.edu" },
]

students = students_data.map do |s|
  User.find_or_create_by!(email: s[:email]) do |u|
    u.first_name = s[:first_name]
    u.last_name  = s[:last_name]
    u.role       = "student"
  end
end
puts "  #{User.students.count} students"

# ── Class Sessions ────────────────────────────────────────────
# Helper: find-or-create a class session
def find_or_create_session(course:, semester:, teacher:, room:, schedule:)
  ClassSession.find_or_create_by!(course: course, semester: semester, teacher: teacher) do |cs|
    cs.room     = room
    cs.schedule = schedule
  end
end

# Fall 2026 sessions
f_eng101  = find_or_create_session(course: courses["ENG101"], semester: fall2026,   teacher: teachers[0], room: "A101", schedule: "MWF 09:00-09:50")
f_mat101  = find_or_create_session(course: courses["MAT101"], semester: fall2026,   teacher: teachers[1], room: "B202", schedule: "TTh 10:00-11:15")
f_sci101  = find_or_create_session(course: courses["SCI101"], semester: fall2026,   teacher: teachers[4], room: "C303", schedule: "MWF 11:00-11:50")
f_his101  = find_or_create_session(course: courses["HIS101"], semester: fall2026,   teacher: teachers[3], room: "D404", schedule: "TTh 13:00-14:15")
f_cs101   = find_or_create_session(course: courses["CS101"],  semester: fall2026,   teacher: teachers[2], room: "E505", schedule: "MWF 14:00-14:50")
f_pe101   = find_or_create_session(course: courses["PE101"],  semester: fall2026,   teacher: teachers[5], room: "GYM1", schedule: "MWF 08:00-08:50")

# Spring 2027 sessions
s_eng201  = find_or_create_session(course: courses["ENG201"], semester: spring2027, teacher: teachers[0], room: "A101", schedule: "MWF 09:00-09:50")
s_mat201  = find_or_create_session(course: courses["MAT201"], semester: spring2027, teacher: teachers[1], room: "B202", schedule: "TTh 10:00-11:15")
s_sci201  = find_or_create_session(course: courses["SCI201"], semester: spring2027, teacher: teachers[4], room: "C303", schedule: "MWF 11:00-11:50")
s_his201  = find_or_create_session(course: courses["HIS201"], semester: spring2027, teacher: teachers[3], room: "D404", schedule: "TTh 13:00-14:15")
s_cs201   = find_or_create_session(course: courses["CS201"],  semester: spring2027, teacher: teachers[2], room: "E505", schedule: "MWF 14:00-14:50")
s_mat301  = find_or_create_session(course: courses["MAT301"], semester: spring2027, teacher: teachers[1], room: "B203", schedule: "TTh 15:00-16:15")

puts "  #{ClassSession.count} class sessions"

# ── Enrollments ───────────────────────────────────────────────
grades = %w[A A- B+ B B- C+ C]

# Enroll all students in Fall 2026 sessions with grades
fall_sessions = [f_eng101, f_mat101, f_sci101, f_his101, f_cs101, f_pe101]
students.each do |student|
  # Each student takes 3-5 fall courses
  chosen = fall_sessions.sample(rand(3..5))
  chosen.each do |cs|
    Enrollment.find_or_create_by!(student: student, class_session: cs) do |e|
      e.grade = grades.sample
    end
  end
end

# Enroll all students in Spring 2027 sessions (no grades yet — semester in future)
spring_sessions = [s_eng201, s_mat201, s_sci201, s_his201, s_cs201, s_mat301]
students.each do |student|
  chosen = spring_sessions.sample(rand(3..5))
  chosen.each do |cs|
    Enrollment.find_or_create_by!(student: student, class_session: cs) do |e|
      e.grade = nil  # not yet graded
    end
  end
end

puts "  #{Enrollment.count} enrollments"
puts "Done! 🎓"
