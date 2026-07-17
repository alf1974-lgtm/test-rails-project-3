# db/seeds.rb
# Clears existing data and populates the database with realistic school data.

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Course.destroy_all
Department.destroy_all
Semester.destroy_all
User.destroy_all

# ─── Departments ────────────────────────────────────────────────────────────────
puts "Creating departments..."
departments = Department.create!([
  { name: "English" },
  { name: "Mathematics" },
  { name: "Science" },
  { name: "History" },
  { name: "Computer Science" }
])

english, math, science, history, cs = departments

# ─── Courses ────────────────────────────────────────────────────────────────────
puts "Creating courses..."
courses = Course.create!([
  # English
  { name: "Composition I",          code: "ENG101", description: "Introduction to academic writing.",                department: english },
  { name: "American Literature",    code: "ENG201", description: "Survey of American literary works.",               department: english },
  # Math
  { name: "Algebra I",              code: "MTH101", description: "Fundamentals of algebra.",                         department: math },
  { name: "Calculus I",             code: "MTH201", description: "Limits, derivatives, and integrals.",              department: math },
  { name: "Statistics",             code: "MTH301", description: "Probability and statistical inference.",           department: math },
  # Science
  { name: "Biology I",              code: "SCI101", description: "Introduction to cell biology and genetics.",       department: science },
  { name: "Chemistry I",            code: "SCI201", description: "Atomic structure and chemical reactions.",         department: science },
  { name: "Physics I",              code: "SCI301", description: "Mechanics, waves, and thermodynamics.",            department: science },
  # History
  { name: "World History",          code: "HIS101", description: "Survey of world history from antiquity.",          department: history },
  { name: "U.S. History",           code: "HIS201", description: "American history from colonization to present.",   department: history },
  # Computer Science
  { name: "Intro to Programming",   code: "CS101",  description: "Programming fundamentals using Python.",           department: cs },
  { name: "Data Structures",        code: "CS201",  description: "Arrays, linked lists, trees, and graphs.",         department: cs }
])

eng101, eng201, mth101, mth201, mth301,
sci101, sci201, sci301, his101, his201,
cs101, cs201 = courses

# ─── Semesters ──────────────────────────────────────────────────────────────────
puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-18")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-19", end_date: "2027-05-14")

# ─── Teachers ───────────────────────────────────────────────────────────────────
puts "Creating teachers..."
teachers = User.create!([
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu",     role: "teacher" },
  { first_name: "Euclid",   last_name: "ofAlexandria", email: "euclid@school.edu",   role: "teacher" }
])

atwood, feynman, lovelace, sagan, euclid = teachers

# ─── Students ───────────────────────────────────────────────────────────────────
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

# ─── Class Sessions ─────────────────────────────────────────────────────────────
puts "Creating class sessions..."

# Fall 2026
cs_eng101_fall   = ClassSession.create!(course: eng101, semester: fall2026,   teacher: atwood,   room: "A101", schedule: "MWF 08:00-08:50")
cs_mth101_fall   = ClassSession.create!(course: mth101, semester: fall2026,   teacher: euclid,   room: "B202", schedule: "MWF 09:00-09:50")
cs_sci101_fall   = ClassSession.create!(course: sci101, semester: fall2026,   teacher: sagan,    room: "C303", schedule: "TTh 10:00-11:15")
cs_his101_fall   = ClassSession.create!(course: his101, semester: fall2026,   teacher: feynman,  room: "D404", schedule: "TTh 13:00-14:15")
cs_cs101_fall    = ClassSession.create!(course: cs101,  semester: fall2026,   teacher: lovelace, room: "E505", schedule: "MWF 14:00-14:50")
cs_mth201_fall   = ClassSession.create!(course: mth201, semester: fall2026,   teacher: euclid,   room: "B203", schedule: "MWF 11:00-11:50")
cs_sci201_fall   = ClassSession.create!(course: sci201, semester: fall2026,   teacher: sagan,    room: "C304", schedule: "TTh 08:00-09:15")

# Spring 2027
cs_eng201_spring = ClassSession.create!(course: eng201, semester: spring2027, teacher: atwood,   room: "A102", schedule: "MWF 08:00-08:50")
cs_mth301_spring = ClassSession.create!(course: mth301, semester: spring2027, teacher: euclid,   room: "B204", schedule: "MWF 10:00-10:50")
cs_sci301_spring = ClassSession.create!(course: sci301, semester: spring2027, teacher: feynman,  room: "C305", schedule: "TTh 10:00-11:15")
cs_his201_spring = ClassSession.create!(course: his201, semester: spring2027, teacher: feynman,  room: "D405", schedule: "TTh 13:00-14:15")
cs_cs201_spring  = ClassSession.create!(course: cs201,  semester: spring2027, teacher: lovelace, room: "E506", schedule: "MWF 14:00-14:50")
cs_cs101_spring  = ClassSession.create!(course: cs101,  semester: spring2027, teacher: lovelace, room: "E505", schedule: "MWF 09:00-09:50")

# ─── Enrollments (students + grades) ────────────────────────────────────────────
puts "Creating enrollments..."

grades = %w[A A- B+ B B- C+ C]

# Helper: enroll a student in a class session with a grade
def enroll(student, class_session, grade)
  Enrollment.create!(student: student, class_session: class_session, grade: grade)
end

# Alice: strong CS/Math student
enroll(alice, cs_cs101_fall,    "A")
enroll(alice, cs_mth101_fall,   "A-")
enroll(alice, cs_eng101_fall,   "B+")
enroll(alice, cs_cs201_spring,  "A")
enroll(alice, cs_mth301_spring, "A-")
enroll(alice, cs_eng201_spring, "B")

# Bob: science-focused
enroll(bob, cs_sci101_fall,   "A-")
enroll(bob, cs_sci201_fall,   "B+")
enroll(bob, cs_mth101_fall,   "B")
enroll(bob, cs_sci301_spring, "A")
enroll(bob, cs_mth301_spring, "B+")
enroll(bob, cs_his201_spring, "B-")

# Carol: humanities student
enroll(carol, cs_eng101_fall,   "A")
enroll(carol, cs_his101_fall,   "A-")
enroll(carol, cs_mth101_fall,   "C+")
enroll(carol, cs_eng201_spring, "A")
enroll(carol, cs_his201_spring, "A-")
enroll(carol, cs_cs101_spring,  "B")

# David: well-rounded
enroll(david, cs_eng101_fall,   "B")
enroll(david, cs_mth101_fall,   "B+")
enroll(david, cs_sci101_fall,   "B")
enroll(david, cs_his101_fall,   "B-")
enroll(david, cs_cs101_fall,    "B+")
enroll(david, cs_mth201_fall,   "C+")
enroll(david, cs_eng201_spring, "B+")
enroll(david, cs_sci301_spring, "B")

# Eva: math/CS focus
enroll(eva, cs_mth101_fall,   "A")
enroll(eva, cs_cs101_fall,    "A")
enroll(eva, cs_mth201_fall,   "A-")
enroll(eva, cs_mth301_spring, "A")
enroll(eva, cs_cs201_spring,  "A-")
enroll(eva, cs_sci301_spring, "B+")

# Frank: history/English focus
enroll(frank, cs_his101_fall,   "A-")
enroll(frank, cs_eng101_fall,   "B+")
enroll(frank, cs_sci101_fall,   "C+")
enroll(frank, cs_his201_spring, "A")
enroll(frank, cs_eng201_spring, "A-")
enroll(frank, cs_cs101_spring,  "C")

# Grace: science/math
enroll(grace, cs_sci101_fall,   "A")
enroll(grace, cs_sci201_fall,   "A-")
enroll(grace, cs_mth201_fall,   "B+")
enroll(grace, cs_sci301_spring, "A")
enroll(grace, cs_mth301_spring, "B+")
enroll(grace, cs_cs201_spring,  "B")

# Henry: mixed
enroll(henry, cs_eng101_fall,   "B-")
enroll(henry, cs_mth101_fall,   "C+")
enroll(henry, cs_his101_fall,   "B")
enroll(henry, cs_cs101_fall,    "B-")
enroll(henry, cs_eng201_spring, "B")
enroll(henry, cs_his201_spring, "B+")

# Iris: CS/science
enroll(iris, cs_cs101_fall,    "A-")
enroll(iris, cs_sci101_fall,   "B+")
enroll(iris, cs_mth101_fall,   "B")
enroll(iris, cs_cs201_spring,  "A-")
enroll(iris, cs_sci301_spring, "B+")
enroll(iris, cs_mth301_spring, "B")

# James: currently enrolled in Spring 2027 with no grades yet
enroll(james, cs_eng201_spring, nil)
enroll(james, cs_his201_spring, nil)
enroll(james, cs_cs101_spring,  nil)
enroll(james, cs_mth301_spring, nil)

puts ""
puts "✅ Seed complete!"
puts "   #{Department.count} departments"
puts "   #{Course.count} courses"
puts "   #{Semester.count} semesters"
puts "   #{User.teachers.count} teachers"
puts "   #{User.students.count} students"
puts "   #{ClassSession.count} class sessions"
puts "   #{Enrollment.count} enrollments"
