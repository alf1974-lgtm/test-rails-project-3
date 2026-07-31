# db/seeds.rb
# Run with: rails db:seed

puts "Seeding database..."

# ── Departments ──────────────────────────────────────────────────────────────
departments = Department.create!([
  { name: "English",     description: "Literature, writing, and language arts" },
  { name: "Mathematics", description: "Algebra, calculus, statistics, and more" },
  { name: "Science",     description: "Biology, chemistry, physics, and earth science" },
  { name: "History",     description: "World history, US history, and social studies" },
  { name: "Computer Science", description: "Programming, algorithms, and software engineering" }
])

english, math, science, history, cs = departments
puts "  Created #{departments.size} departments"

# ── Courses ───────────────────────────────────────────────────────────────────
courses = Course.create!([
  { name: "English Composition",   code: "ENG101", credits: 3, department: english,  description: "Fundamentals of academic writing" },
  { name: "American Literature",   code: "ENG201", credits: 3, department: english,  description: "Survey of American literary works" },
  { name: "Algebra I",             code: "MAT101", credits: 3, department: math,     description: "Introduction to algebraic concepts" },
  { name: "Calculus I",            code: "MAT201", credits: 4, department: math,     description: "Limits, derivatives, and integrals" },
  { name: "Statistics",            code: "MAT301", credits: 3, department: math,     description: "Probability and statistical analysis" },
  { name: "Biology",               code: "SCI101", credits: 4, department: science,  description: "Introduction to living systems" },
  { name: "Chemistry",             code: "SCI201", credits: 4, department: science,  description: "Atomic structure and chemical reactions" },
  { name: "World History",         code: "HIS101", credits: 3, department: history,  description: "Survey of world civilizations" },
  { name: "US History",            code: "HIS201", credits: 3, department: history,  description: "American history from colonial era to present" },
  { name: "Intro to Programming",  code: "CS101",  credits: 3, department: cs,       description: "Programming fundamentals using Python" },
  { name: "Data Structures",       code: "CS201",  credits: 3, department: cs,       description: "Arrays, linked lists, trees, and graphs" },
  { name: "Web Development",       code: "CS301",  credits: 3, department: cs,       description: "HTML, CSS, JavaScript, and Rails" }
])

puts "  Created #{courses.size} courses"

# ── Semesters ─────────────────────────────────────────────────────────────────
fall2026 = Semester.create!(
  name: "Fall 2026",
  term: "Fall",
  year: 2026,
  start_date: Date.new(2026, 8, 24),
  end_date:   Date.new(2026, 12, 15)
)

spring2027 = Semester.create!(
  name: "Spring 2027",
  term: "Spring",
  year: 2027,
  start_date: Date.new(2027, 1, 19),
  end_date:   Date.new(2027, 5, 10)
)

puts "  Created 2 semesters"

# ── Teachers ──────────────────────────────────────────────────────────────────
teachers = User.create!([
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Marie",    last_name: "Curie",     email: "m.curie@school.edu",     role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",      role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" }
])

t_english, t_math, t_science, t_history, t_cs = teachers
puts "  Created #{teachers.size} teachers"

# ── Students ──────────────────────────────────────────────────────────────────
students = User.create!([
  { first_name: "Alice",   last_name: "Johnson",   email: "alice.johnson@students.edu",   role: "student" },
  { first_name: "Bob",     last_name: "Smith",     email: "bob.smith@students.edu",       role: "student" },
  { first_name: "Carol",   last_name: "Williams",  email: "carol.williams@students.edu",  role: "student" },
  { first_name: "David",   last_name: "Brown",     email: "david.brown@students.edu",     role: "student" },
  { first_name: "Eva",     last_name: "Davis",     email: "eva.davis@students.edu",       role: "student" },
  { first_name: "Frank",   last_name: "Miller",    email: "frank.miller@students.edu",    role: "student" },
  { first_name: "Grace",   last_name: "Wilson",    email: "grace.wilson@students.edu",    role: "student" },
  { first_name: "Henry",   last_name: "Moore",     email: "henry.moore@students.edu",     role: "student" },
  { first_name: "Iris",    last_name: "Taylor",    email: "iris.taylor@students.edu",     role: "student" },
  { first_name: "Jack",    last_name: "Anderson",  email: "jack.anderson@students.edu",   role: "student" }
])

alice, bob, carol, david, eva, frank, grace, henry, iris, jack = students
puts "  Created #{students.size} students"

# ── Class Sessions ────────────────────────────────────────────────────────────
# Fall 2026
eng101_fall   = ClassSession.create!(course: courses[0],  semester: fall2026,   teacher: t_english,  room: "A101", schedule: "MWF 9:00-9:50am")
eng201_fall   = ClassSession.create!(course: courses[1],  semester: fall2026,   teacher: t_english,  room: "A102", schedule: "TTh 10:00-11:15am")
mat101_fall   = ClassSession.create!(course: courses[2],  semester: fall2026,   teacher: t_math,     room: "B201", schedule: "MWF 10:00-10:50am")
mat201_fall   = ClassSession.create!(course: courses[3],  semester: fall2026,   teacher: t_math,     room: "B202", schedule: "MWF 11:00-11:50am")
sci101_fall   = ClassSession.create!(course: courses[5],  semester: fall2026,   teacher: t_science,  room: "C301", schedule: "TTh 1:00-2:15pm")
his101_fall   = ClassSession.create!(course: courses[7],  semester: fall2026,   teacher: t_history,  room: "D401", schedule: "MWF 2:00-2:50pm")
cs101_fall    = ClassSession.create!(course: courses[9],  semester: fall2026,   teacher: t_cs,       room: "E501", schedule: "TTh 3:00-4:15pm")

# Spring 2027
mat301_spring = ClassSession.create!(course: courses[4],  semester: spring2027, teacher: t_math,     room: "B203", schedule: "MWF 9:00-9:50am")
sci201_spring = ClassSession.create!(course: courses[6],  semester: spring2027, teacher: t_science,  room: "C302", schedule: "TTh 10:00-11:15am")
his201_spring = ClassSession.create!(course: courses[8],  semester: spring2027, teacher: t_history,  room: "D402", schedule: "MWF 11:00-11:50am")
cs201_spring  = ClassSession.create!(course: courses[10], semester: spring2027, teacher: t_cs,       room: "E502", schedule: "TTh 1:00-2:15pm")
cs301_spring  = ClassSession.create!(course: courses[11], semester: spring2027, teacher: t_cs,       room: "E503", schedule: "MWF 2:00-2:50pm")

puts "  Created 12 class sessions"

# ── Enrollments ───────────────────────────────────────────────────────────────
# Fall 2026 enrollments (with grades — semester is over)
Enrollment.create!([
  # ENG101 Fall
  { class_session: eng101_fall, student: alice,  grade: "A",  status: "completed" },
  { class_session: eng101_fall, student: bob,    grade: "B+", status: "completed" },
  { class_session: eng101_fall, student: carol,  grade: "A-", status: "completed" },
  { class_session: eng101_fall, student: david,  grade: "C+", status: "completed" },
  { class_session: eng101_fall, student: eva,    grade: "B",  status: "completed" },

  # ENG201 Fall
  { class_session: eng201_fall, student: frank,  grade: "B-", status: "completed" },
  { class_session: eng201_fall, student: grace,  grade: "A",  status: "completed" },

  # MAT101 Fall
  { class_session: mat101_fall, student: alice,  grade: "B+", status: "completed" },
  { class_session: mat101_fall, student: bob,    grade: "A",  status: "completed" },
  { class_session: mat101_fall, student: henry,  grade: "C",  status: "completed" },
  { class_session: mat101_fall, student: iris,   grade: "B",  status: "completed" },
  { class_session: mat101_fall, student: jack,   grade: "A-", status: "completed" },

  # MAT201 Fall
  { class_session: mat201_fall, student: carol,  grade: "A",  status: "completed" },
  { class_session: mat201_fall, student: david,  grade: "B",  status: "completed" },
  { class_session: mat201_fall, student: eva,    grade: "A-", status: "completed" },

  # SCI101 Fall
  { class_session: sci101_fall, student: frank,  grade: "B+", status: "completed" },
  { class_session: sci101_fall, student: grace,  grade: "A",  status: "completed" },
  { class_session: sci101_fall, student: henry,  grade: "B-", status: "completed" },
  { class_session: sci101_fall, student: alice,  grade: "A-", status: "completed" },

  # HIS101 Fall
  { class_session: his101_fall, student: iris,   grade: "B+", status: "completed" },
  { class_session: his101_fall, student: jack,   grade: "A",  status: "completed" },
  { class_session: his101_fall, student: bob,    grade: "B",  status: "completed" },
  { class_session: his101_fall, student: carol,  grade: "A-", status: "completed" },

  # CS101 Fall
  { class_session: cs101_fall,  student: david,  grade: "A",  status: "completed" },
  { class_session: cs101_fall,  student: eva,    grade: "B+", status: "completed" },
  { class_session: cs101_fall,  student: frank,  grade: "A-", status: "completed" },
  { class_session: cs101_fall,  student: grace,  grade: "B",  status: "completed" },
  { class_session: cs101_fall,  student: henry,  grade: "C+", status: "completed" },
])

# Spring 2027 enrollments (in progress — no grades yet)
Enrollment.create!([
  # MAT301 Spring
  { class_session: mat301_spring, student: alice,  status: "enrolled" },
  { class_session: mat301_spring, student: carol,  status: "enrolled" },
  { class_session: mat301_spring, student: eva,    status: "enrolled" },

  # SCI201 Spring
  { class_session: sci201_spring, student: bob,    status: "enrolled" },
  { class_session: sci201_spring, student: frank,  status: "enrolled" },
  { class_session: sci201_spring, student: grace,  status: "enrolled" },
  { class_session: sci201_spring, student: alice,  status: "enrolled" },

  # HIS201 Spring
  { class_session: his201_spring, student: iris,   status: "enrolled" },
  { class_session: his201_spring, student: jack,   status: "enrolled" },
  { class_session: his201_spring, student: henry,  status: "enrolled" },

  # CS201 Spring
  { class_session: cs201_spring,  student: david,  status: "enrolled" },
  { class_session: cs201_spring,  student: eva,    status: "enrolled" },
  { class_session: cs201_spring,  student: frank,  status: "enrolled" },
  { class_session: cs201_spring,  student: grace,  status: "enrolled" },

  # CS301 Spring
  { class_session: cs301_spring,  student: alice,  status: "enrolled" },
  { class_session: cs301_spring,  student: bob,    status: "enrolled" },
  { class_session: cs301_spring,  student: carol,  status: "enrolled" },
  { class_session: cs301_spring,  student: henry,  status: "enrolled" },
  { class_session: cs301_spring,  student: iris,   status: "enrolled" },
])

puts "  Created enrollments"
puts "\nDone! 🎓"
puts "\nSample student IDs for testing:"
students.each { |s| puts "  #{s.id}: #{s.full_name} (#{s.email})" }
