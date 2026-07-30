# db/seeds.rb
# Clears existing data and re-seeds the database.

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Semester.destroy_all
Course.destroy_all
Department.destroy_all
User.destroy_all

# ── Departments ──────────────────────────────────────────────────────────────
puts "Creating departments..."
english  = Department.create!(name: "English")
math     = Department.create!(name: "Math")
science  = Department.create!(name: "Science")
history  = Department.create!(name: "History")
cs_dept  = Department.create!(name: "Computer Science")

# ── Courses ───────────────────────────────────────────────────────────────────
puts "Creating courses..."
courses = [
  { name: "Composition I",          code: "ENG101", description: "Introduction to academic writing.",          department: english },
  { name: "British Literature",     code: "ENG201", description: "Survey of British literature.",              department: english },
  { name: "Calculus I",             code: "MTH101", description: "Limits, derivatives, and integrals.",        department: math    },
  { name: "Linear Algebra",         code: "MTH201", description: "Vectors, matrices, and linear maps.",        department: math    },
  { name: "Biology 101",            code: "SCI101", description: "Fundamentals of biology.",                   department: science },
  { name: "Chemistry 101",          code: "SCI102", description: "Fundamentals of chemistry.",                 department: science },
  { name: "World History",          code: "HIS101", description: "Survey of world history.",                   department: history },
  { name: "US History",             code: "HIS201", description: "United States history from 1776 onward.",   department: history },
  { name: "Intro to Programming",   code: "CS101",  description: "Programming fundamentals using Python.",     department: cs_dept },
  { name: "Data Structures",        code: "CS201",  description: "Arrays, linked lists, trees, and graphs.",   department: cs_dept },
].map { |attrs| Course.create!(attrs) }

eng101, eng201, mth101, mth201, sci101, sci102, his101, his201, cs101, cs201 = courses

# ── Semesters ─────────────────────────────────────────────────────────────────
puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-15")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-19", end_date: "2027-05-10")

# ── Teachers ──────────────────────────────────────────────────────────────────
puts "Creating teachers..."
teachers = [
  { name: "Dr. Alice Monroe",   email: "alice.monroe@school.edu",   role: "teacher" },
  { name: "Prof. Bob Nguyen",   email: "bob.nguyen@school.edu",     role: "teacher" },
  { name: "Dr. Carol Patel",    email: "carol.patel@school.edu",    role: "teacher" },
  { name: "Prof. David Kim",    email: "david.kim@school.edu",      role: "teacher" },
  { name: "Dr. Eva Rosenberg",  email: "eva.rosenberg@school.edu",  role: "teacher" },
].map { |attrs| User.create!(attrs) }

alice, bob, carol, david, eva = teachers

# ── Students ──────────────────────────────────────────────────────────────────
puts "Creating students..."
students = [
  { name: "Sam Torres",     email: "sam.torres@students.edu",     role: "student" },
  { name: "Jamie Lee",      email: "jamie.lee@students.edu",      role: "student" },
  { name: "Morgan Davis",   email: "morgan.davis@students.edu",   role: "student" },
  { name: "Riley Johnson",  email: "riley.johnson@students.edu",  role: "student" },
  { name: "Casey Brown",    email: "casey.brown@students.edu",    role: "student" },
  { name: "Jordan Smith",   email: "jordan.smith@students.edu",   role: "student" },
  { name: "Taylor White",   email: "taylor.white@students.edu",   role: "student" },
  { name: "Alex Green",     email: "alex.green@students.edu",     role: "student" },
].map { |attrs| User.create!(attrs) }

sam, jamie, morgan, riley, casey, jordan, taylor, alex = students

# ── Class Sessions ────────────────────────────────────────────────────────────
puts "Creating class sessions..."

# Fall 2026
cs101_fall   = ClassSession.create!(course: cs101,  semester: fall2026,   teacher: alice, room: "Tech 101",  schedule: "MWF 9:00-9:50")
mth101_fall  = ClassSession.create!(course: mth101, semester: fall2026,   teacher: bob,   room: "Math 202",  schedule: "TTh 10:00-11:15")
eng101_fall  = ClassSession.create!(course: eng101, semester: fall2026,   teacher: carol, room: "Hum 305",   schedule: "MWF 11:00-11:50")
sci101_fall  = ClassSession.create!(course: sci101, semester: fall2026,   teacher: david, room: "Sci 110",   schedule: "TTh 1:00-2:15")
his101_fall  = ClassSession.create!(course: his101, semester: fall2026,   teacher: eva,   room: "Hum 201",   schedule: "MWF 2:00-2:50")

# Spring 2027
cs201_spr    = ClassSession.create!(course: cs201,  semester: spring2027, teacher: alice, room: "Tech 101",  schedule: "MWF 9:00-9:50")
mth201_spr   = ClassSession.create!(course: mth201, semester: spring2027, teacher: bob,   room: "Math 202",  schedule: "TTh 10:00-11:15")
eng201_spr   = ClassSession.create!(course: eng201, semester: spring2027, teacher: carol, room: "Hum 305",   schedule: "MWF 11:00-11:50")
sci102_spr   = ClassSession.create!(course: sci102, semester: spring2027, teacher: david, room: "Sci 110",   schedule: "TTh 1:00-2:15")
his201_spr   = ClassSession.create!(course: his201, semester: spring2027, teacher: eva,   room: "Hum 201",   schedule: "MWF 2:00-2:50")

# ── Enrollments ───────────────────────────────────────────────────────────────
puts "Creating enrollments..."

# Sam: CS and Math focus
Enrollment.create!(class_session: cs101_fall,  student: sam,    grade: "A")
Enrollment.create!(class_session: mth101_fall, student: sam,    grade: "A-")
Enrollment.create!(class_session: eng101_fall, student: sam,    grade: "B+")
Enrollment.create!(class_session: cs201_spr,   student: sam,    grade: nil)
Enrollment.create!(class_session: mth201_spr,  student: sam,    grade: nil)

# Jamie: English and History focus
Enrollment.create!(class_session: eng101_fall, student: jamie,  grade: "A-")
Enrollment.create!(class_session: his101_fall, student: jamie,  grade: "B+")
Enrollment.create!(class_session: eng201_spr,  student: jamie,  grade: nil)
Enrollment.create!(class_session: his201_spr,  student: jamie,  grade: nil)

# Morgan: Science focus
Enrollment.create!(class_session: sci101_fall, student: morgan, grade: "B")
Enrollment.create!(class_session: mth101_fall, student: morgan, grade: "B-")
Enrollment.create!(class_session: sci102_spr,  student: morgan, grade: nil)
Enrollment.create!(class_session: mth201_spr,  student: morgan, grade: nil)

# Riley: Mixed
Enrollment.create!(class_session: cs101_fall,  student: riley,  grade: "B+")
Enrollment.create!(class_session: sci101_fall, student: riley,  grade: "A-")
Enrollment.create!(class_session: his101_fall, student: riley,  grade: "B")
Enrollment.create!(class_session: cs201_spr,   student: riley,  grade: nil)

# Casey: Mixed
Enrollment.create!(class_session: eng101_fall, student: casey,  grade: "C+")
Enrollment.create!(class_session: mth101_fall, student: casey,  grade: "C")
Enrollment.create!(class_session: his101_fall, student: casey,  grade: "B-")
Enrollment.create!(class_session: eng201_spr,  student: casey,  grade: nil)

# Jordan, Taylor, Alex: lighter loads
Enrollment.create!(class_session: cs101_fall,  student: jordan, grade: "A")
Enrollment.create!(class_session: his101_fall, student: jordan, grade: "A-")
Enrollment.create!(class_session: cs201_spr,   student: jordan, grade: nil)

Enrollment.create!(class_session: sci101_fall, student: taylor, grade: "B+")
Enrollment.create!(class_session: eng101_fall, student: taylor, grade: "B")
Enrollment.create!(class_session: sci102_spr,  student: taylor, grade: nil)

Enrollment.create!(class_session: mth101_fall, student: alex,   grade: "A")
Enrollment.create!(class_session: cs101_fall,  student: alex,   grade: "A-")
Enrollment.create!(class_session: mth201_spr,  student: alex,   grade: nil)

puts ""
puts "Seed complete!"
puts "  #{Department.count} departments"
puts "  #{Course.count} courses"
puts "  #{Semester.count} semesters"
puts "  #{User.teachers.count} teachers"
puts "  #{User.students.count} students"
puts "  #{ClassSession.count} class sessions"
puts "  #{Enrollment.count} enrollments"
