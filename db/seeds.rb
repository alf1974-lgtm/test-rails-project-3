# db/seeds.rb
# Run with: rails db:seed
# Clears and repopulates all data.

puts "Seeding database..."

# ── Clean slate ──────────────────────────────────────────────────────────────
Enrollment.delete_all
ClassSession.delete_all
Semester.delete_all
Course.delete_all
Department.delete_all
User.delete_all

# ── Departments ───────────────────────────────────────────────────────────────
departments = Department.create!([
  { name: "English",  description: "Language, literature, and writing" },
  { name: "Math",     description: "Mathematics and statistics" },
  { name: "Science",  description: "Natural and physical sciences" },
  { name: "History",  description: "World and American history" },
  { name: "Computer Science", description: "Programming, algorithms, and systems" }
])

eng, math, sci, hist, cs = departments
puts "  Created #{departments.size} departments"

# ── Courses ───────────────────────────────────────────────────────────────────
courses = Course.create!([
  # English
  { name: "Composition I",          code: "ENG101", credits: 3, department: eng,
    description: "Introduction to academic writing" },
  { name: "American Literature",    code: "ENG201", credits: 3, department: eng,
    description: "Survey of American literary works" },
  # Math
  { name: "Calculus I",             code: "MAT101", credits: 4, department: math,
    description: "Limits, derivatives, and integrals" },
  { name: "Statistics",             code: "MAT201", credits: 3, department: math,
    description: "Probability and statistical inference" },
  # Science
  { name: "Biology I",              code: "SCI101", credits: 4, department: sci,
    description: "Cell biology and genetics" },
  { name: "Chemistry I",            code: "SCI102", credits: 4, department: sci,
    description: "Atomic structure and chemical reactions" },
  # History
  { name: "World History",          code: "HIS101", credits: 3, department: hist,
    description: "Survey of world civilizations" },
  { name: "US History",             code: "HIS201", credits: 3, department: hist,
    description: "American history from colonial era to present" },
  # CS
  { name: "Intro to Programming",   code: "CS101",  credits: 3, department: cs,
    description: "Programming fundamentals using Python" },
  { name: "Data Structures",        code: "CS201",  credits: 3, department: cs,
    description: "Arrays, linked lists, trees, and graphs" }
])

puts "  Created #{courses.size} courses"

# ── Semesters ─────────────────────────────────────────────────────────────────
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-15")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-19", end_date: "2027-05-10")
puts "  Created 2 semesters"

# ── Teachers ──────────────────────────────────────────────────────────────────
teachers = User.create!([
  { first_name: "Margaret", last_name: "Atwood",   email: "m.atwood@school.edu",   role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",  email: "r.feynman@school.edu",  role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace", email: "a.lovelace@school.edu", role: "teacher" },
  { first_name: "Carl",     last_name: "Sagan",    email: "c.sagan@school.edu",    role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",     email: "h.zinn@school.edu",     role: "teacher" }
])

t_eng, t_math, t_cs, t_sci, t_hist = teachers
puts "  Created #{teachers.size} teachers"

# ── Students ──────────────────────────────────────────────────────────────────
students = User.create!([
  { first_name: "Alice",   last_name: "Johnson",  email: "alice.johnson@students.edu",  role: "student" },
  { first_name: "Bob",     last_name: "Smith",    email: "bob.smith@students.edu",      role: "student" },
  { first_name: "Carol",   last_name: "Williams", email: "carol.williams@students.edu", role: "student" },
  { first_name: "David",   last_name: "Brown",    email: "david.brown@students.edu",    role: "student" },
  { first_name: "Eva",     last_name: "Davis",    email: "eva.davis@students.edu",      role: "student" },
  { first_name: "Frank",   last_name: "Miller",   email: "frank.miller@students.edu",   role: "student" },
  { first_name: "Grace",   last_name: "Wilson",   email: "grace.wilson@students.edu",   role: "student" },
  { first_name: "Henry",   last_name: "Moore",    email: "henry.moore@students.edu",    role: "student" }
])

alice, bob, carol, david, eva, frank, grace, henry = students
puts "  Created #{students.size} students"

# ── Class Sessions ────────────────────────────────────────────────────────────
# Fall 2026
cs_eng101_f26   = ClassSession.create!(course: courses[0], semester: fall2026,   teacher: t_eng,  room: "A101", schedule: "MWF 09:00-09:50")
cs_mat101_f26   = ClassSession.create!(course: courses[2], semester: fall2026,   teacher: t_math, room: "B202", schedule: "TTh 10:00-11:15")
cs_sci101_f26   = ClassSession.create!(course: courses[4], semester: fall2026,   teacher: t_sci,  room: "C303", schedule: "MWF 11:00-11:50")
cs_his101_f26   = ClassSession.create!(course: courses[6], semester: fall2026,   teacher: t_hist, room: "D404", schedule: "TTh 13:00-14:15")
cs_cs101_f26    = ClassSession.create!(course: courses[8], semester: fall2026,   teacher: t_cs,   room: "E505", schedule: "MWF 14:00-14:50")

# Spring 2027
cs_eng201_s27   = ClassSession.create!(course: courses[1], semester: spring2027, teacher: t_eng,  room: "A101", schedule: "MWF 09:00-09:50")
cs_mat201_s27   = ClassSession.create!(course: courses[3], semester: spring2027, teacher: t_math, room: "B202", schedule: "TTh 10:00-11:15")
cs_sci102_s27   = ClassSession.create!(course: courses[5], semester: spring2027, teacher: t_sci,  room: "C303", schedule: "MWF 11:00-11:50")
cs_his201_s27   = ClassSession.create!(course: courses[7], semester: spring2027, teacher: t_hist, room: "D404", schedule: "TTh 13:00-14:15")
cs_cs201_s27    = ClassSession.create!(course: courses[9], semester: spring2027, teacher: t_cs,   room: "E505", schedule: "MWF 14:00-14:50")

puts "  Created 10 class sessions"

# ── Enrollments (with grades for Fall 2026, pending for Spring 2027) ──────────
grades = %w[A A- B+ B B- C+]

[
  # Alice: CS-focused
  [alice, cs_cs101_f26,  "A"],
  [alice, cs_mat101_f26, "A-"],
  [alice, cs_eng101_f26, "B+"],
  [alice, cs_cs201_s27,  nil],
  [alice, cs_mat201_s27, nil],

  # Bob: History/English
  [bob, cs_his101_f26,  "B"],
  [bob, cs_eng101_f26,  "B+"],
  [bob, cs_his201_s27,  nil],
  [bob, cs_eng201_s27,  nil],

  # Carol: Science track
  [carol, cs_sci101_f26, "A"],
  [carol, cs_mat101_f26, "A-"],
  [carol, cs_sci102_s27, nil],
  [carol, cs_mat201_s27, nil],

  # David: mixed
  [david, cs_eng101_f26, "C+"],
  [david, cs_his101_f26, "B-"],
  [david, cs_cs101_f26,  "B"],
  [david, cs_eng201_s27, nil],

  # Eva: science + CS
  [eva, cs_sci101_f26, "A-"],
  [eva, cs_cs101_f26,  "A"],
  [eva, cs_sci102_s27, nil],
  [eva, cs_cs201_s27,  nil],

  # Frank: history focus
  [frank, cs_his101_f26, "B+"],
  [frank, cs_eng101_f26, "B"],
  [frank, cs_his201_s27, nil],

  # Grace: math/CS
  [grace, cs_mat101_f26, "A"],
  [grace, cs_cs101_f26,  "A-"],
  [grace, cs_mat201_s27, nil],
  [grace, cs_cs201_s27,  nil],

  # Henry: broad
  [henry, cs_eng101_f26, "B-"],
  [henry, cs_sci101_f26, "C+"],
  [henry, cs_his101_f26, "B"],
  [henry, cs_eng201_s27, nil],
  [henry, cs_sci102_s27, nil]
].each do |student, session, grade|
  Enrollment.create!(student: student, class_session: session, grade: grade)
end

puts "  Created #{Enrollment.count} enrollments"
puts ""
puts "Done! Summary:"
puts "  Departments:    #{Department.count}"
puts "  Courses:        #{Course.count}"
puts "  Semesters:      #{Semester.count}"
puts "  Teachers:       #{User.teachers.count}"
puts "  Students:       #{User.students.count}"
puts "  Class Sessions: #{ClassSession.count}"
puts "  Enrollments:    #{Enrollment.count}"
puts ""
puts "Sample student IDs:"
User.students.each { |s| puts "  #{s.id}: #{s.full_name} (#{s.email})" }
