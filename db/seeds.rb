# db/seeds.rb
# Run with: rails db:seed
# Clears existing data and repopulates with sample school data.

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Course.destroy_all
Department.destroy_all
Semester.destroy_all
User.destroy_all

# ─── Departments ────────────────────────────────────────────────────────────
puts "Creating departments..."

english    = Department.create!(name: "English",    description: "Literature, writing, and language arts")
math       = Department.create!(name: "Mathematics", description: "Pure and applied mathematics")
science    = Department.create!(name: "Science",    description: "Natural sciences: biology, chemistry, physics")
history    = Department.create!(name: "History",    description: "World and American history")
cs         = Department.create!(name: "Computer Science", description: "Programming, algorithms, and systems")

# ─── Semesters ──────────────────────────────────────────────────────────────
puts "Creating semesters..."

fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-15")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-19", end_date: "2027-05-10")

# ─── Courses ────────────────────────────────────────────────────────────────
puts "Creating courses..."

# English
eng101 = Course.create!(name: "Composition I",          code: "ENG101", credits: 3, department: english,
                         description: "Introduction to academic writing and rhetoric")
eng201 = Course.create!(name: "American Literature",    code: "ENG201", credits: 3, department: english,
                         description: "Survey of American literature from colonial times to present")

# Mathematics
mth101 = Course.create!(name: "College Algebra",        code: "MTH101", credits: 3, department: math,
                         description: "Algebraic concepts, functions, and graphs")
mth201 = Course.create!(name: "Calculus I",             code: "MTH201", credits: 4, department: math,
                         description: "Limits, derivatives, and integrals")
mth301 = Course.create!(name: "Linear Algebra",         code: "MTH301", credits: 3, department: math,
                         description: "Vectors, matrices, and linear transformations")

# Science
sci101 = Course.create!(name: "Biology I",              code: "SCI101", credits: 4, department: science,
                         description: "Cell biology, genetics, and evolution")
sci201 = Course.create!(name: "Chemistry I",            code: "SCI201", credits: 4, department: science,
                         description: "Atomic structure, bonding, and reactions")
sci301 = Course.create!(name: "Physics I",              code: "SCI301", credits: 4, department: science,
                         description: "Mechanics, kinematics, and Newton's laws")

# History
his101 = Course.create!(name: "World History I",        code: "HIS101", credits: 3, department: history,
                         description: "Ancient civilizations through the Renaissance")
his201 = Course.create!(name: "US History",             code: "HIS201", credits: 3, department: history,
                         description: "American history from colonization to the present")

# Computer Science
csc101 = Course.create!(name: "Intro to Programming",  code: "CSC101", credits: 3, department: cs,
                         description: "Fundamentals of programming using Python")
csc201 = Course.create!(name: "Data Structures",       code: "CSC201", credits: 3, department: cs,
                         description: "Arrays, linked lists, trees, graphs, and algorithms")
csc301 = Course.create!(name: "Web Development",       code: "CSC301", credits: 3, department: cs,
                         description: "HTML, CSS, JavaScript, and backend frameworks")

# ─── Teachers ───────────────────────────────────────────────────────────────
puts "Creating teachers..."

teachers = [
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu",     role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",      role: "teacher" },
  { first_name: "Grace",    last_name: "Hopper",    email: "g.hopper@school.edu",    role: "teacher" },
].map { |attrs| User.create!(attrs) }

t_atwood, t_feynman, t_lovelace, t_sagan, t_zinn, t_hopper = teachers

# ─── Students ───────────────────────────────────────────────────────────────
puts "Creating students..."

students = [
  { first_name: "Alice",   last_name: "Johnson",  email: "alice.johnson@student.edu",  role: "student" },
  { first_name: "Bob",     last_name: "Smith",    email: "bob.smith@student.edu",      role: "student" },
  { first_name: "Carol",   last_name: "Williams", email: "carol.williams@student.edu", role: "student" },
  { first_name: "David",   last_name: "Brown",    email: "david.brown@student.edu",    role: "student" },
  { first_name: "Eva",     last_name: "Davis",    email: "eva.davis@student.edu",      role: "student" },
  { first_name: "Frank",   last_name: "Miller",   email: "frank.miller@student.edu",   role: "student" },
  { first_name: "Grace",   last_name: "Wilson",   email: "grace.wilson@student.edu",   role: "student" },
  { first_name: "Henry",   last_name: "Moore",    email: "henry.moore@student.edu",    role: "student" },
  { first_name: "Iris",    last_name: "Taylor",   email: "iris.taylor@student.edu",    role: "student" },
  { first_name: "James",   last_name: "Anderson", email: "james.anderson@student.edu", role: "student" },
].map { |attrs| User.create!(attrs) }

alice, bob, carol, david, eva, frank, grace, henry, iris, james = students

# ─── Class Sessions ─────────────────────────────────────────────────────────
puts "Creating class sessions..."

# Fall 2026 sessions
cs_eng101_f26  = ClassSession.create!(course: eng101, semester: fall2026,  teacher: t_atwood,
                                       room: "HUM 101", schedule: "MWF 9:00-9:50am")
cs_mth101_f26  = ClassSession.create!(course: mth101, semester: fall2026,  teacher: t_feynman,
                                       room: "SCI 210", schedule: "TTh 10:00-11:15am")
cs_mth201_f26  = ClassSession.create!(course: mth201, semester: fall2026,  teacher: t_feynman,
                                       room: "SCI 212", schedule: "MWF 11:00-11:50am")
cs_sci101_f26  = ClassSession.create!(course: sci101, semester: fall2026,  teacher: t_sagan,
                                       room: "SCI 301", schedule: "TTh 1:00-2:15pm")
cs_his101_f26  = ClassSession.create!(course: his101, semester: fall2026,  teacher: t_zinn,
                                       room: "HUM 205", schedule: "MWF 2:00-2:50pm")
cs_csc101_f26  = ClassSession.create!(course: csc101, semester: fall2026,  teacher: t_hopper,
                                       room: "CS 110",  schedule: "TTh 3:00-4:15pm")
cs_csc201_f26  = ClassSession.create!(course: csc201, semester: fall2026,  teacher: t_lovelace,
                                       room: "CS 120",  schedule: "MWF 10:00-10:50am")

# Spring 2027 sessions
cs_eng201_s27  = ClassSession.create!(course: eng201, semester: spring2027, teacher: t_atwood,
                                       room: "HUM 102", schedule: "MWF 9:00-9:50am")
cs_mth301_s27  = ClassSession.create!(course: mth301, semester: spring2027, teacher: t_feynman,
                                       room: "SCI 210", schedule: "TTh 10:00-11:15am")
cs_sci201_s27  = ClassSession.create!(course: sci201, semester: spring2027, teacher: t_sagan,
                                       room: "SCI 302", schedule: "TTh 1:00-2:15pm")
cs_sci301_s27  = ClassSession.create!(course: sci301, semester: spring2027, teacher: t_sagan,
                                       room: "SCI 303", schedule: "MWF 11:00-11:50am")
cs_his201_s27  = ClassSession.create!(course: his201, semester: spring2027, teacher: t_zinn,
                                       room: "HUM 206", schedule: "MWF 2:00-2:50pm")
cs_csc301_s27  = ClassSession.create!(course: csc301, semester: spring2027, teacher: t_hopper,
                                       room: "CS 130",  schedule: "TTh 3:00-4:15pm")

# ─── Enrollments ────────────────────────────────────────────────────────────
puts "Creating enrollments..."

grades = %w[A A- B+ B B- C+ C C- D+ D]

# Alice: CS-focused student, enrolled in both semesters
Enrollment.create!(class_session: cs_csc101_f26, student: alice, grade: "A")
Enrollment.create!(class_session: cs_mth101_f26, student: alice, grade: "B+")
Enrollment.create!(class_session: cs_eng101_f26, student: alice, grade: "A-")
Enrollment.create!(class_session: cs_csc201_f26, student: alice, grade: "A")
Enrollment.create!(class_session: cs_csc301_s27, student: alice, grade: nil)   # in progress
Enrollment.create!(class_session: cs_mth301_s27, student: alice, grade: nil)

# Bob: Science-focused
Enrollment.create!(class_session: cs_sci101_f26, student: bob, grade: "B")
Enrollment.create!(class_session: cs_mth101_f26, student: bob, grade: "C+")
Enrollment.create!(class_session: cs_eng101_f26, student: bob, grade: "B-")
Enrollment.create!(class_session: cs_sci201_s27, student: bob, grade: nil)
Enrollment.create!(class_session: cs_sci301_s27, student: bob, grade: nil)

# Carol: Humanities-focused
Enrollment.create!(class_session: cs_eng101_f26, student: carol, grade: "A")
Enrollment.create!(class_session: cs_his101_f26, student: carol, grade: "A-")
Enrollment.create!(class_session: cs_mth101_f26, student: carol, grade: "B")
Enrollment.create!(class_session: cs_eng201_s27, student: carol, grade: nil)
Enrollment.create!(class_session: cs_his201_s27, student: carol, grade: nil)

# David: Mixed
Enrollment.create!(class_session: cs_csc101_f26, student: david, grade: "B+")
Enrollment.create!(class_session: cs_sci101_f26, student: david, grade: "B")
Enrollment.create!(class_session: cs_his101_f26, student: david, grade: "A-")
Enrollment.create!(class_session: cs_csc301_s27, student: david, grade: nil)
Enrollment.create!(class_session: cs_his201_s27, student: david, grade: nil)

# Eva: Math-focused
Enrollment.create!(class_session: cs_mth101_f26, student: eva, grade: "A")
Enrollment.create!(class_session: cs_mth201_f26, student: eva, grade: "A-")
Enrollment.create!(class_session: cs_sci101_f26, student: eva, grade: "B+")
Enrollment.create!(class_session: cs_mth301_s27, student: eva, grade: nil)
Enrollment.create!(class_session: cs_sci201_s27, student: eva, grade: nil)

# Frank: CS + History
Enrollment.create!(class_session: cs_csc101_f26, student: frank, grade: "C+")
Enrollment.create!(class_session: cs_csc201_f26, student: frank, grade: "B-")
Enrollment.create!(class_session: cs_his101_f26, student: frank, grade: "B+")
Enrollment.create!(class_session: cs_csc301_s27, student: frank, grade: nil)

# Grace: Science + English
Enrollment.create!(class_session: cs_sci101_f26, student: grace, grade: "A-")
Enrollment.create!(class_session: cs_eng101_f26, student: grace, grade: "B+")
Enrollment.create!(class_session: cs_mth201_f26, student: grace, grade: "B")
Enrollment.create!(class_session: cs_sci201_s27, student: grace, grade: nil)
Enrollment.create!(class_session: cs_eng201_s27, student: grace, grade: nil)

# Henry: Broad schedule
Enrollment.create!(class_session: cs_eng101_f26, student: henry, grade: "B")
Enrollment.create!(class_session: cs_mth101_f26, student: henry, grade: "C")
Enrollment.create!(class_session: cs_csc101_f26, student: henry, grade: "B+")
Enrollment.create!(class_session: cs_his101_f26, student: henry, grade: "A")
Enrollment.create!(class_session: cs_his201_s27, student: henry, grade: nil)

# Iris: Science + CS
Enrollment.create!(class_session: cs_sci101_f26, student: iris, grade: "A")
Enrollment.create!(class_session: cs_csc101_f26, student: iris, grade: "A-")
Enrollment.create!(class_session: cs_mth201_f26, student: iris, grade: "B+")
Enrollment.create!(class_session: cs_sci301_s27, student: iris, grade: nil)
Enrollment.create!(class_session: cs_csc301_s27, student: iris, grade: nil)

# James: History + English
Enrollment.create!(class_session: cs_his101_f26, student: james, grade: "B+")
Enrollment.create!(class_session: cs_eng101_f26, student: james, grade: "A-")
Enrollment.create!(class_session: cs_mth101_f26, student: james, grade: "D+")
Enrollment.create!(class_session: cs_his201_s27, student: james, grade: nil)
Enrollment.create!(class_session: cs_eng201_s27, student: james, grade: nil)

puts ""
puts "✅ Seed complete!"
puts "   #{Department.count} departments"
puts "   #{Semester.count} semesters"
puts "   #{Course.count} courses"
puts "   #{User.teachers.count} teachers"
puts "   #{User.students.count} students"
puts "   #{ClassSession.count} class sessions"
puts "   #{Enrollment.count} enrollments"
puts ""
puts "Sample student IDs:"
User.students.order(:first_name).each do |s|
  puts "   #{s.id}: #{s.full_name} (#{s.email})"
end
