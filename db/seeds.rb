# db/seeds.rb
# Clears existing data and repopulates with realistic school data.

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Semester.destroy_all
Course.destroy_all
Department.destroy_all
User.destroy_all

# ─── Departments ────────────────────────────────────────────────────────────

puts "Creating departments..."
departments = Department.create!([
  { name: "English" },
  { name: "Mathematics" },
  { name: "Science" },
  { name: "History" },
  { name: "Computer Science" }
])

english, math, science, history, cs = departments

# ─── Courses ────────────────────────────────────────────────────────────────

puts "Creating courses..."
courses = Course.create!([
  # English
  { name: "Introduction to Literature",  code: "ENG101", credits: 3, department: english,
    description: "Survey of major literary works from antiquity to the modern era." },
  { name: "Composition and Rhetoric",    code: "ENG102", credits: 3, department: english,
    description: "Develops academic writing and argumentation skills." },
  { name: "Creative Writing",            code: "ENG201", credits: 3, department: english,
    description: "Workshop-based course in fiction and poetry." },

  # Mathematics
  { name: "Calculus I",                  code: "MAT101", credits: 4, department: math,
    description: "Limits, derivatives, and an introduction to integration." },
  { name: "Calculus II",                 code: "MAT102", credits: 4, department: math,
    description: "Techniques of integration, sequences, and series." },
  { name: "Linear Algebra",             code: "MAT201", credits: 3, department: math,
    description: "Vectors, matrices, and linear transformations." },

  # Science
  { name: "General Biology",             code: "SCI101", credits: 4, department: science,
    description: "Fundamentals of cell biology, genetics, and evolution." },
  { name: "General Chemistry",           code: "SCI102", credits: 4, department: science,
    description: "Atomic structure, bonding, and chemical reactions." },
  { name: "Physics I",                   code: "SCI201", credits: 4, department: science,
    description: "Mechanics, thermodynamics, and waves." },

  # History
  { name: "World History I",             code: "HIS101", credits: 3, department: history,
    description: "Ancient civilizations through the early modern period." },
  { name: "World History II",            code: "HIS102", credits: 3, department: history,
    description: "The modern era from 1500 to the present." },
  { name: "US History",                  code: "HIS201", credits: 3, department: history,
    description: "American history from colonization to the 21st century." },

  # Computer Science
  { name: "Intro to Programming",        code: "CS101",  credits: 3, department: cs,
    description: "Fundamentals of programming using Python." },
  { name: "Data Structures",             code: "CS201",  credits: 3, department: cs,
    description: "Arrays, linked lists, trees, graphs, and algorithm analysis." },
  { name: "Web Development",             code: "CS301",  credits: 3, department: cs,
    description: "HTML, CSS, JavaScript, and introduction to backend frameworks." }
])

# ─── Semesters ───────────────────────────────────────────────────────────────

puts "Creating semesters..."
fall2026 = Semester.create!(
  name:       "Fall 2026",
  start_date: Date.new(2026, 8, 24),
  end_date:   Date.new(2026, 12, 18)
)

spring2027 = Semester.create!(
  name:       "Spring 2027",
  start_date: Date.new(2027, 1, 11),
  end_date:   Date.new(2027, 5, 7)
)

# ─── Teachers ────────────────────────────────────────────────────────────────

puts "Creating teachers..."
teachers = User.create!([
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu",     role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",      role: "teacher" }
])

t_english, t_math, t_cs, t_science, t_history = teachers

# ─── Students ────────────────────────────────────────────────────────────────

puts "Creating students..."
students = User.create!([
  { first_name: "Alice",   last_name: "Johnson",  email: "alice.johnson@students.edu",  role: "student" },
  { first_name: "Bob",     last_name: "Smith",    email: "bob.smith@students.edu",      role: "student" },
  { first_name: "Carol",   last_name: "Williams", email: "carol.williams@students.edu", role: "student" },
  { first_name: "David",   last_name: "Brown",    email: "david.brown@students.edu",    role: "student" },
  { first_name: "Eva",     last_name: "Davis",    email: "eva.davis@students.edu",      role: "student" },
  { first_name: "Frank",   last_name: "Miller",   email: "frank.miller@students.edu",   role: "student" },
  { first_name: "Grace",   last_name: "Wilson",   email: "grace.wilson@students.edu",   role: "student" },
  { first_name: "Henry",   last_name: "Moore",    email: "henry.moore@students.edu",    role: "student" },
  { first_name: "Iris",    last_name: "Taylor",   email: "iris.taylor@students.edu",    role: "student" },
  { first_name: "James",   last_name: "Anderson", email: "james.anderson@students.edu", role: "student" }
])

alice, bob, carol, david, eva, frank, grace, henry, iris, james = students

# ─── Class Sessions ──────────────────────────────────────────────────────────

puts "Creating class sessions..."

# Helper to find a course by code
def course(code) = Course.find_by!(code: code)

# Fall 2026 sessions
eng101_fall   = ClassSession.create!(course: course("ENG101"), semester: fall2026,  teacher: t_english, room: "Humanities 101", schedule: "MWF 9:00-9:50")
mat101_fall   = ClassSession.create!(course: course("MAT101"), semester: fall2026,  teacher: t_math,    room: "Science 204",    schedule: "MWF 10:00-10:50")
sci101_fall   = ClassSession.create!(course: course("SCI101"), semester: fall2026,  teacher: t_science, room: "Lab 301",        schedule: "TTh 9:30-10:45")
his101_fall   = ClassSession.create!(course: course("HIS101"), semester: fall2026,  teacher: t_history, room: "Social 102",     schedule: "TTh 11:00-12:15")
cs101_fall    = ClassSession.create!(course: course("CS101"),  semester: fall2026,  teacher: t_cs,      room: "Tech 105",       schedule: "MWF 1:00-1:50")
eng102_fall   = ClassSession.create!(course: course("ENG102"), semester: fall2026,  teacher: t_english, room: "Humanities 102", schedule: "TTh 2:00-3:15")
mat102_fall   = ClassSession.create!(course: course("MAT102"), semester: fall2026,  teacher: t_math,    room: "Science 205",    schedule: "MWF 11:00-11:50")

# Spring 2027 sessions
eng201_spring = ClassSession.create!(course: course("ENG201"), semester: spring2027, teacher: t_english, room: "Humanities 103", schedule: "MWF 9:00-9:50")
mat201_spring = ClassSession.create!(course: course("MAT201"), semester: spring2027, teacher: t_math,    room: "Science 206",    schedule: "MWF 10:00-10:50")
sci102_spring = ClassSession.create!(course: course("SCI102"), semester: spring2027, teacher: t_science, room: "Lab 302",        schedule: "TTh 9:30-10:45")
his102_spring = ClassSession.create!(course: course("HIS102"), semester: spring2027, teacher: t_history, room: "Social 103",     schedule: "TTh 11:00-12:15")
cs201_spring  = ClassSession.create!(course: course("CS201"),  semester: spring2027, teacher: t_cs,      room: "Tech 106",       schedule: "MWF 1:00-1:50")
sci201_spring = ClassSession.create!(course: course("SCI201"), semester: spring2027, teacher: t_science, room: "Lab 303",        schedule: "MWF 2:00-2:50")
his201_spring = ClassSession.create!(course: course("HIS201"), semester: spring2027, teacher: t_history, room: "Social 104",     schedule: "TTh 2:00-3:15")
cs301_spring  = ClassSession.create!(course: course("CS301"),  semester: spring2027, teacher: t_cs,      room: "Tech 107",       schedule: "TTh 3:30-4:45")

# ─── Enrollments ─────────────────────────────────────────────────────────────

puts "Creating enrollments..."

grades = %w[A A- B+ B B- C+ C]

# Alice: CS-focused student
Enrollment.create!(class_session: cs101_fall,    student: alice, grade: "A")
Enrollment.create!(class_session: mat101_fall,   student: alice, grade: "A-")
Enrollment.create!(class_session: eng101_fall,   student: alice, grade: "B+")
Enrollment.create!(class_session: cs201_spring,  student: alice, grade: "A")
Enrollment.create!(class_session: mat201_spring, student: alice, grade: "B+")
Enrollment.create!(class_session: cs301_spring,  student: alice, grade: nil)  # in progress

# Bob: Science-focused student
Enrollment.create!(class_session: sci101_fall,   student: bob, grade: "A-")
Enrollment.create!(class_session: mat101_fall,   student: bob, grade: "B")
Enrollment.create!(class_session: his101_fall,   student: bob, grade: "B+")
Enrollment.create!(class_session: sci102_spring, student: bob, grade: "A")
Enrollment.create!(class_session: sci201_spring, student: bob, grade: nil)

# Carol: Humanities-focused student
Enrollment.create!(class_session: eng101_fall,   student: carol, grade: "A")
Enrollment.create!(class_session: his101_fall,   student: carol, grade: "A-")
Enrollment.create!(class_session: eng102_fall,   student: carol, grade: "A")
Enrollment.create!(class_session: eng201_spring, student: carol, grade: "A-")
Enrollment.create!(class_session: his102_spring, student: carol, grade: nil)

# David: Mixed
Enrollment.create!(class_session: cs101_fall,    student: david, grade: "B")
Enrollment.create!(class_session: eng101_fall,   student: david, grade: "B+")
Enrollment.create!(class_session: sci101_fall,   student: david, grade: "C+")
Enrollment.create!(class_session: his201_spring, student: david, grade: nil)
Enrollment.create!(class_session: cs201_spring,  student: david, grade: nil)

# Eva
Enrollment.create!(class_session: mat101_fall,   student: eva, grade: "A")
Enrollment.create!(class_session: mat102_fall,   student: eva, grade: "A-")
Enrollment.create!(class_session: sci101_fall,   student: eva, grade: "A")
Enrollment.create!(class_session: mat201_spring, student: eva, grade: nil)
Enrollment.create!(class_session: sci102_spring, student: eva, grade: nil)

# Frank
Enrollment.create!(class_session: his101_fall,   student: frank, grade: "B-")
Enrollment.create!(class_session: eng102_fall,   student: frank, grade: "C+")
Enrollment.create!(class_session: cs101_fall,    student: frank, grade: "B")
Enrollment.create!(class_session: his102_spring, student: frank, grade: nil)
Enrollment.create!(class_session: eng201_spring, student: frank, grade: nil)

# Grace
Enrollment.create!(class_session: sci101_fall,   student: grace, grade: "B+")
Enrollment.create!(class_session: mat101_fall,   student: grace, grade: "B")
Enrollment.create!(class_session: eng101_fall,   student: grace, grade: "A-")
Enrollment.create!(class_session: sci102_spring, student: grace, grade: nil)
Enrollment.create!(class_session: cs301_spring,  student: grace, grade: nil)

# Henry
Enrollment.create!(class_session: cs101_fall,    student: henry, grade: "A-")
Enrollment.create!(class_session: mat102_fall,   student: henry, grade: "B+")
Enrollment.create!(class_session: his101_fall,   student: henry, grade: "B")
Enrollment.create!(class_session: cs201_spring,  student: henry, grade: nil)
Enrollment.create!(class_session: his201_spring, student: henry, grade: nil)

# Iris
Enrollment.create!(class_session: eng101_fall,   student: iris, grade: "A")
Enrollment.create!(class_session: eng102_fall,   student: iris, grade: "A-")
Enrollment.create!(class_session: sci101_fall,   student: iris, grade: "B+")
Enrollment.create!(class_session: eng201_spring, student: iris, grade: nil)
Enrollment.create!(class_session: sci201_spring, student: iris, grade: nil)

# James
Enrollment.create!(class_session: his101_fall,   student: james, grade: "C+")
Enrollment.create!(class_session: cs101_fall,    student: james, grade: "B-")
Enrollment.create!(class_session: mat101_fall,   student: james, grade: "C")
Enrollment.create!(class_session: his102_spring, student: james, grade: nil)
Enrollment.create!(class_session: cs301_spring,  student: james, grade: nil)

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
puts "Sample student IDs:"
User.students.order(:first_name).each do |s|
  puts "   #{s.id}: #{s.full_name} (#{s.email})"
end
