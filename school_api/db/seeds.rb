# db/seeds.rb
# Clears existing data and populates the database with realistic school data.

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Semester.destroy_all
Course.destroy_all
Department.destroy_all
User.destroy_all

# ─── Departments ────────────────────────────────────────────────────────────

puts "Creating departments..."
english    = Department.create!(name: "English")
math       = Department.create!(name: "Mathematics")
science    = Department.create!(name: "Science")
history    = Department.create!(name: "History")
cs         = Department.create!(name: "Computer Science")

# ─── Courses ────────────────────────────────────────────────────────────────

puts "Creating courses..."

# English
eng101 = Course.create!(name: "Composition I",          code: "ENG101", credits: 3, department: english,
                        description: "Introduction to academic writing and rhetoric.")
eng201 = Course.create!(name: "American Literature",    code: "ENG201", credits: 3, department: english,
                        description: "Survey of American literature from colonial times to the present.")

# Mathematics
mat101 = Course.create!(name: "Pre-Calculus",           code: "MAT101", credits: 3, department: math,
                        description: "Functions, trigonometry, and analytic geometry.")
mat201 = Course.create!(name: "Calculus I",             code: "MAT201", credits: 4, department: math,
                        description: "Limits, derivatives, and integrals of single-variable functions.")
mat301 = Course.create!(name: "Linear Algebra",         code: "MAT301", credits: 3, department: math,
                        description: "Vectors, matrices, and linear transformations.")

# Science
sci101 = Course.create!(name: "Biology I",              code: "SCI101", credits: 4, department: science,
                        description: "Cell biology, genetics, and evolution.")
sci201 = Course.create!(name: "Chemistry I",            code: "SCI201", credits: 4, department: science,
                        description: "Atomic structure, bonding, and chemical reactions.")
sci301 = Course.create!(name: "Physics I",              code: "SCI301", credits: 4, department: science,
                        description: "Mechanics, kinematics, and Newton's laws.")

# History
his101 = Course.create!(name: "World History I",        code: "HIS101", credits: 3, department: history,
                        description: "Ancient civilizations through the Middle Ages.")
his201 = Course.create!(name: "U.S. History",           code: "HIS201", credits: 3, department: history,
                        description: "American history from colonization to the present.")

# Computer Science
csc101 = Course.create!(name: "Intro to Programming",  code: "CSC101", credits: 3, department: cs,
                        description: "Fundamentals of programming using Python.")
csc201 = Course.create!(name: "Data Structures",       code: "CSC201", credits: 3, department: cs,
                        description: "Arrays, linked lists, trees, graphs, and algorithm analysis.")
csc301 = Course.create!(name: "Web Development",       code: "CSC301", credits: 3, department: cs,
                        description: "HTML, CSS, JavaScript, and introductory back-end development.")

# ─── Semesters ──────────────────────────────────────────────────────────────

puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-18")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-11", end_date: "2027-05-07")

# ─── Teachers ───────────────────────────────────────────────────────────────

puts "Creating teachers..."
teachers = [
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu",     role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",      role: "teacher" },
  { first_name: "Euclid",   last_name: "ofAlexandria", email: "euclid@school.edu",   role: "teacher" }
].map { |attrs| User.create!(attrs) }

t_atwood, t_feynman, t_lovelace, t_sagan, t_zinn, t_euclid = teachers

# ─── Students ───────────────────────────────────────────────────────────────

puts "Creating students..."
students = [
  { first_name: "Alice",   last_name: "Johnson",  email: "alice.johnson@students.edu"  },
  { first_name: "Bob",     last_name: "Smith",    email: "bob.smith@students.edu"      },
  { first_name: "Carol",   last_name: "Williams", email: "carol.williams@students.edu" },
  { first_name: "David",   last_name: "Brown",    email: "david.brown@students.edu"    },
  { first_name: "Eva",     last_name: "Davis",    email: "eva.davis@students.edu"      },
  { first_name: "Frank",   last_name: "Miller",   email: "frank.miller@students.edu"   },
  { first_name: "Grace",   last_name: "Wilson",   email: "grace.wilson@students.edu"   },
  { first_name: "Henry",   last_name: "Moore",    email: "henry.moore@students.edu"    },
  { first_name: "Iris",    last_name: "Taylor",   email: "iris.taylor@students.edu"    },
  { first_name: "James",   last_name: "Anderson", email: "james.anderson@students.edu" }
].map { |attrs| User.create!(attrs.merge(role: "student")) }

alice, bob, carol, david, eva, frank, grace, henry, iris, james = students

# ─── Class Sessions ─────────────────────────────────────────────────────────

puts "Creating class sessions..."

# Fall 2026
cs_eng101_fall   = ClassSession.create!(course: eng101, semester: fall2026,   teacher: t_atwood,   room: "HUM 101", schedule: "MWF 09:00-09:50")
cs_mat201_fall   = ClassSession.create!(course: mat201, semester: fall2026,   teacher: t_euclid,   room: "SCI 210", schedule: "TTh 10:00-11:15")
cs_sci101_fall   = ClassSession.create!(course: sci101, semester: fall2026,   teacher: t_sagan,    room: "SCI 105", schedule: "MWF 11:00-11:50")
cs_his101_fall   = ClassSession.create!(course: his101, semester: fall2026,   teacher: t_zinn,     room: "HUM 205", schedule: "TTh 13:00-14:15")
cs_csc101_fall   = ClassSession.create!(course: csc101, semester: fall2026,   teacher: t_lovelace, room: "CS  301", schedule: "MWF 14:00-14:50")
cs_sci301_fall   = ClassSession.create!(course: sci301, semester: fall2026,   teacher: t_feynman,  room: "SCI 310", schedule: "TTh 15:00-16:15")

# Spring 2027
cs_eng201_spr    = ClassSession.create!(course: eng201, semester: spring2027, teacher: t_atwood,   room: "HUM 102", schedule: "MWF 09:00-09:50")
cs_mat301_spr    = ClassSession.create!(course: mat301, semester: spring2027, teacher: t_euclid,   room: "SCI 211", schedule: "TTh 10:00-11:15")
cs_sci201_spr    = ClassSession.create!(course: sci201, semester: spring2027, teacher: t_sagan,    room: "SCI 106", schedule: "MWF 11:00-11:50")
cs_his201_spr    = ClassSession.create!(course: his201, semester: spring2027, teacher: t_zinn,     room: "HUM 206", schedule: "TTh 13:00-14:15")
cs_csc201_spr    = ClassSession.create!(course: csc201, semester: spring2027, teacher: t_lovelace, room: "CS  302", schedule: "MWF 14:00-14:50")
cs_csc301_spr    = ClassSession.create!(course: csc301, semester: spring2027, teacher: t_lovelace, room: "CS  303", schedule: "TTh 15:00-16:15")

# ─── Enrollments ────────────────────────────────────────────────────────────

puts "Creating enrollments..."

grades = %w[A A- B+ B B- C+ C]

# Alice: heavy CS track
Enrollment.create!(student: alice, class_session: cs_csc101_fall,  grade: "A")
Enrollment.create!(student: alice, class_session: cs_mat201_fall,  grade: "A-")
Enrollment.create!(student: alice, class_session: cs_eng101_fall,  grade: "B+")
Enrollment.create!(student: alice, class_session: cs_csc201_spr,   grade: "A")
Enrollment.create!(student: alice, class_session: cs_csc301_spr,   grade: nil)   # in progress
Enrollment.create!(student: alice, class_session: cs_mat301_spr,   grade: nil)

# Bob: science track
Enrollment.create!(student: bob, class_session: cs_sci101_fall,  grade: "B+")
Enrollment.create!(student: bob, class_session: cs_mat201_fall,  grade: "B")
Enrollment.create!(student: bob, class_session: cs_eng101_fall,  grade: "C+")
Enrollment.create!(student: bob, class_session: cs_sci201_spr,   grade: "B+")
Enrollment.create!(student: bob, class_session: cs_sci301_fall,  grade: "B")

# Carol: humanities track
Enrollment.create!(student: carol, class_session: cs_eng101_fall,  grade: "A")
Enrollment.create!(student: carol, class_session: cs_his101_fall,  grade: "A-")
Enrollment.create!(student: carol, class_session: cs_eng201_spr,   grade: nil)
Enrollment.create!(student: carol, class_session: cs_his201_spr,   grade: nil)

# David: mixed
Enrollment.create!(student: david, class_session: cs_mat201_fall,  grade: "C+")
Enrollment.create!(student: david, class_session: cs_sci101_fall,  grade: "B-")
Enrollment.create!(student: david, class_session: cs_his101_fall,  grade: "B")
Enrollment.create!(student: david, class_session: cs_csc101_fall,  grade: "B+")
Enrollment.create!(student: david, class_session: cs_csc201_spr,   grade: nil)

# Eva
Enrollment.create!(student: eva, class_session: cs_eng101_fall,  grade: "A-")
Enrollment.create!(student: eva, class_session: cs_sci101_fall,  grade: "A")
Enrollment.create!(student: eva, class_session: cs_mat201_fall,  grade: "B+")
Enrollment.create!(student: eva, class_session: cs_sci201_spr,   grade: nil)

# Frank
Enrollment.create!(student: frank, class_session: cs_his101_fall,  grade: "B-")
Enrollment.create!(student: frank, class_session: cs_eng101_fall,  grade: "C")
Enrollment.create!(student: frank, class_session: cs_sci301_fall,  grade: "C+")
Enrollment.create!(student: frank, class_session: cs_his201_spr,   grade: nil)

# Grace
Enrollment.create!(student: grace, class_session: cs_csc101_fall,  grade: "A-")
Enrollment.create!(student: grace, class_session: cs_sci101_fall,  grade: "B+")
Enrollment.create!(student: grace, class_session: cs_csc201_spr,   grade: nil)
Enrollment.create!(student: grace, class_session: cs_csc301_spr,   grade: nil)

# Henry
Enrollment.create!(student: henry, class_session: cs_mat201_fall,  grade: "A")
Enrollment.create!(student: henry, class_session: cs_sci301_fall,  grade: "A-")
Enrollment.create!(student: henry, class_session: cs_mat301_spr,   grade: nil)

# Iris
Enrollment.create!(student: iris, class_session: cs_eng101_fall,  grade: "B")
Enrollment.create!(student: iris, class_session: cs_his101_fall,  grade: "B+")
Enrollment.create!(student: iris, class_session: cs_eng201_spr,   grade: nil)
Enrollment.create!(student: iris, class_session: cs_his201_spr,   grade: nil)

# James
Enrollment.create!(student: james, class_session: cs_csc101_fall,  grade: "B-")
Enrollment.create!(student: james, class_session: cs_mat201_fall,  grade: "C+")
Enrollment.create!(student: james, class_session: cs_sci101_fall,  grade: "C")
Enrollment.create!(student: james, class_session: cs_csc201_spr,   grade: nil)

puts ""
puts "✅  Seed complete!"
puts "   #{Department.count}   departments"
puts "   #{Course.count}      courses"
puts "   #{Semester.count}    semesters"
puts "   #{User.teachers.count}  teachers"
puts "   #{User.students.count} students"
puts "   #{ClassSession.count}  class sessions"
puts "   #{Enrollment.count}  enrollments"
