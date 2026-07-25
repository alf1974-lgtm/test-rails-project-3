# db/seeds.rb
# Clears existing data and seeds the school database

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Semester.destroy_all
Course.destroy_all
Department.destroy_all
User.destroy_all

# ─── Departments ────────────────────────────────────────────────────────────────
puts "Creating departments..."
departments = Department.create!([
  { name: "English",     code: "ENG" },
  { name: "Mathematics", code: "MATH" },
  { name: "Science",     code: "SCI" },
  { name: "History",     code: "HIST" },
  { name: "Computer Science", code: "CS" }
])

eng, math, sci, hist, cs = departments

# ─── Courses ────────────────────────────────────────────────────────────────────
puts "Creating courses..."
courses = Course.create!([
  { name: "Introduction to Literature",   code: "ENG101",  credits: 3, department: eng,  description: "Survey of classic and contemporary literature." },
  { name: "Creative Writing",             code: "ENG201",  credits: 3, department: eng,  description: "Workshop-based creative writing course." },
  { name: "Calculus I",                   code: "MATH101", credits: 4, department: math, description: "Limits, derivatives, and integrals." },
  { name: "Linear Algebra",               code: "MATH201", credits: 3, department: math, description: "Vectors, matrices, and linear transformations." },
  { name: "Biology 101",                  code: "SCI101",  credits: 4, department: sci,  description: "Fundamentals of cell biology and genetics." },
  { name: "Chemistry 101",                code: "SCI102",  credits: 4, department: sci,  description: "Atomic structure, bonding, and reactions." },
  { name: "World History",                code: "HIST101", credits: 3, department: hist, description: "Survey of world history from antiquity to 1900." },
  { name: "US History",                   code: "HIST201", credits: 3, department: hist, description: "American history from colonial era to present." },
  { name: "Introduction to Programming",  code: "CS101",   credits: 3, department: cs,   description: "Programming fundamentals using Python." },
  { name: "Data Structures",              code: "CS201",   credits: 3, department: cs,   description: "Arrays, linked lists, trees, and graphs." }
])

eng101, eng201, math101, math201, sci101, sci102, hist101, hist201, cs101, cs201 = courses

# ─── Semesters ──────────────────────────────────────────────────────────────────
puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-15")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-19", end_date: "2027-05-10")

# ─── Teachers ───────────────────────────────────────────────────────────────────
puts "Creating teachers..."
teachers = User.create!([
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Jane",     last_name: "Goodall",   email: "j.goodall@school.edu",   role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",      role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" }
])

atwood, feynman, goodall, zinn, lovelace = teachers

# ─── Students ───────────────────────────────────────────────────────────────────
puts "Creating students..."
students = User.create!([
  { first_name: "Alice",   last_name: "Johnson",  email: "alice.johnson@school.edu",  role: "student" },
  { first_name: "Bob",     last_name: "Smith",    email: "bob.smith@school.edu",      role: "student" },
  { first_name: "Carol",   last_name: "Williams", email: "carol.williams@school.edu", role: "student" },
  { first_name: "David",   last_name: "Brown",    email: "david.brown@school.edu",    role: "student" },
  { first_name: "Eva",     last_name: "Davis",    email: "eva.davis@school.edu",      role: "student" },
  { first_name: "Frank",   last_name: "Miller",   email: "frank.miller@school.edu",   role: "student" },
  { first_name: "Grace",   last_name: "Wilson",   email: "grace.wilson@school.edu",   role: "student" },
  { first_name: "Henry",   last_name: "Moore",    email: "henry.moore@school.edu",    role: "student" }
])

alice, bob, carol, david, eva, frank, grace, henry = students

# ─── Class Sessions ─────────────────────────────────────────────────────────────
puts "Creating class sessions..."

# Fall 2026
cs_eng101_fall   = ClassSession.create!(course: eng101,  semester: fall2026,   teacher: atwood,   room: "HUM 101", schedule: "MWF 09:00-09:50")
cs_math101_fall  = ClassSession.create!(course: math101, semester: fall2026,   teacher: feynman,  room: "SCI 210", schedule: "MWF 10:00-10:50")
cs_sci101_fall   = ClassSession.create!(course: sci101,  semester: fall2026,   teacher: goodall,  room: "SCI 105", schedule: "TTh 11:00-12:15")
cs_hist101_fall  = ClassSession.create!(course: hist101, semester: fall2026,   teacher: zinn,     room: "HUM 205", schedule: "TTh 14:00-15:15")
cs_cs101_fall    = ClassSession.create!(course: cs101,   semester: fall2026,   teacher: lovelace, room: "ENG 301", schedule: "MWF 13:00-13:50")

# Spring 2027
cs_eng201_spr    = ClassSession.create!(course: eng201,  semester: spring2027, teacher: atwood,   room: "HUM 102", schedule: "MWF 09:00-09:50")
cs_math201_spr   = ClassSession.create!(course: math201, semester: spring2027, teacher: feynman,  room: "SCI 211", schedule: "MWF 11:00-11:50")
cs_sci102_spr    = ClassSession.create!(course: sci102,  semester: spring2027, teacher: goodall,  room: "SCI 106", schedule: "TTh 09:30-10:45")
cs_hist201_spr   = ClassSession.create!(course: hist201, semester: spring2027, teacher: zinn,     room: "HUM 206", schedule: "TTh 13:00-14:15")
cs_cs201_spr     = ClassSession.create!(course: cs201,   semester: spring2027, teacher: lovelace, room: "ENG 302", schedule: "MWF 14:00-14:50")

# ─── Enrollments ────────────────────────────────────────────────────────────────
puts "Creating enrollments..."

# Alice: CS-focused, both semesters
Enrollment.create!(student: alice, class_session: cs_cs101_fall,   grade: "A")
Enrollment.create!(student: alice, class_session: cs_math101_fall,  grade: "A-")
Enrollment.create!(student: alice, class_session: cs_eng101_fall,   grade: "B+")
Enrollment.create!(student: alice, class_session: cs_cs201_spr,     grade: nil)
Enrollment.create!(student: alice, class_session: cs_math201_spr,   grade: nil)

# Bob: History/English focus
Enrollment.create!(student: bob, class_session: cs_hist101_fall,  grade: "B")
Enrollment.create!(student: bob, class_session: cs_eng101_fall,   grade: "B+")
Enrollment.create!(student: bob, class_session: cs_sci101_fall,   grade: "C+")
Enrollment.create!(student: bob, class_session: cs_hist201_spr,   grade: nil)
Enrollment.create!(student: bob, class_session: cs_eng201_spr,    grade: nil)

# Carol: Science focus
Enrollment.create!(student: carol, class_session: cs_sci101_fall,  grade: "A")
Enrollment.create!(student: carol, class_session: cs_math101_fall, grade: "A")
Enrollment.create!(student: carol, class_session: cs_cs101_fall,   grade: "B")
Enrollment.create!(student: carol, class_session: cs_sci102_spr,   grade: nil)
Enrollment.create!(student: carol, class_session: cs_math201_spr,  grade: nil)

# David: Mixed
Enrollment.create!(student: david, class_session: cs_hist101_fall, grade: "B-")
Enrollment.create!(student: david, class_session: cs_eng101_fall,  grade: "C+")
Enrollment.create!(student: david, class_session: cs_math101_fall, grade: "B")
Enrollment.create!(student: david, class_session: cs_hist201_spr,  grade: nil)

# Eva: CS/Math
Enrollment.create!(student: eva, class_session: cs_cs101_fall,   grade: "A-")
Enrollment.create!(student: eva, class_session: cs_math101_fall,  grade: "B+")
Enrollment.create!(student: eva, class_session: cs_cs201_spr,    grade: nil)

# Frank: Broad
Enrollment.create!(student: frank, class_session: cs_eng101_fall,  grade: "B")
Enrollment.create!(student: frank, class_session: cs_sci101_fall,  grade: "B-")
Enrollment.create!(student: frank, class_session: cs_hist101_fall, grade: "A-")
Enrollment.create!(student: frank, class_session: cs_eng201_spr,   grade: nil)
Enrollment.create!(student: frank, class_session: cs_sci102_spr,   grade: nil)

# Grace: Science/CS
Enrollment.create!(student: grace, class_session: cs_sci101_fall,  grade: "A")
Enrollment.create!(student: grace, class_session: cs_cs101_fall,   grade: "A")
Enrollment.create!(student: grace, class_session: cs_sci102_spr,   grade: nil)
Enrollment.create!(student: grace, class_session: cs_cs201_spr,    grade: nil)

# Henry: History/English
Enrollment.create!(student: henry, class_session: cs_hist101_fall, grade: "C")
Enrollment.create!(student: henry, class_session: cs_eng101_fall,  grade: "B-")
Enrollment.create!(student: henry, class_session: cs_hist201_spr,  grade: nil)
Enrollment.create!(student: henry, class_session: cs_eng201_spr,   grade: nil)

puts ""
puts "✅ Seed complete!"
puts "   #{Department.count} departments"
puts "   #{Course.count} courses"
puts "   #{Semester.count} semesters"
puts "   #{User.teachers.count} teachers"
puts "   #{User.students.count} students"
puts "   #{ClassSession.count} class sessions"
puts "   #{Enrollment.count} enrollments"
puts ""
puts "Student IDs for testing:"
User.students.order(:id).each do |s|
  puts "   #{s.id}: #{s.full_name} (#{s.email})"
end
