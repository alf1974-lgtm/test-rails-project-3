# db/seeds.rb
# Clears existing data and seeds the school database.

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
User.destroy_all
Course.destroy_all
Department.destroy_all
Semester.destroy_all

# ─── Departments ────────────────────────────────────────────────────────────

puts "Creating departments..."

departments = Department.create!([
  { name: "English",     code: "ENG",  description: "Literature, writing, and language arts" },
  { name: "Mathematics", code: "MATH", description: "Pure and applied mathematics" },
  { name: "Science",     code: "SCI",  description: "Natural and physical sciences" },
  { name: "History",     code: "HIST", description: "World and American history" },
  { name: "Computer Science", code: "CS", description: "Programming, algorithms, and systems" }
])

eng, math, sci, hist, cs = departments

# ─── Courses ────────────────────────────────────────────────────────────────

puts "Creating courses..."

courses = Course.create!([
  # English
  { name: "Composition I",          code: "ENG101", credits: 3, department: eng,
    description: "Introduction to academic writing and rhetoric" },
  { name: "American Literature",    code: "ENG201", credits: 3, department: eng,
    description: "Survey of American literature from colonial times to present" },
  { name: "Creative Writing",       code: "ENG310", credits: 3, department: eng,
    description: "Workshop in fiction, poetry, and creative nonfiction" },

  # Math
  { name: "Calculus I",             code: "MATH101", credits: 4, department: math,
    description: "Limits, derivatives, and integrals of single-variable functions" },
  { name: "Linear Algebra",         code: "MATH201", credits: 3, department: math,
    description: "Vectors, matrices, and linear transformations" },
  { name: "Statistics",             code: "MATH210", credits: 3, department: math,
    description: "Probability, distributions, and statistical inference" },

  # Science
  { name: "Biology I",              code: "SCI101", credits: 4, department: sci,
    description: "Cell biology, genetics, and evolution" },
  { name: "Chemistry I",            code: "SCI110", credits: 4, department: sci,
    description: "Atomic structure, bonding, and chemical reactions" },
  { name: "Physics I",              code: "SCI120", credits: 4, department: sci,
    description: "Mechanics, thermodynamics, and waves" },

  # History
  { name: "World History I",        code: "HIST101", credits: 3, department: hist,
    description: "Ancient civilizations through the Renaissance" },
  { name: "US History",             code: "HIST201", credits: 3, department: hist,
    description: "American history from colonization to the present" },

  # Computer Science
  { name: "Intro to Programming",   code: "CS101", credits: 3, department: cs,
    description: "Fundamentals of programming using Python" },
  { name: "Data Structures",        code: "CS201", credits: 3, department: cs,
    description: "Arrays, linked lists, trees, graphs, and algorithms" },
  { name: "Web Development",        code: "CS310", credits: 3, department: cs,
    description: "HTML, CSS, JavaScript, and modern web frameworks" }
])

# ─── Semesters ───────────────────────────────────────────────────────────────

puts "Creating semesters..."

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
  start_date: Date.new(2027, 1, 11),
  end_date:   Date.new(2027, 5, 10)
)

# ─── Teachers ────────────────────────────────────────────────────────────────

puts "Creating teachers..."

teachers = User.create!([
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",
    role: "teacher", employee_id: "T001" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",
    role: "teacher", employee_id: "T002" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",
    role: "teacher", employee_id: "T003" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",
    role: "teacher", employee_id: "T004" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu",
    role: "teacher", employee_id: "T005" },
  { first_name: "Grace",    last_name: "Hopper",    email: "g.hopper@school.edu",
    role: "teacher", employee_id: "T006" }
])

t_atwood, t_feynman, t_lovelace, t_zinn, t_sagan, t_hopper = teachers

# ─── Students ────────────────────────────────────────────────────────────────

puts "Creating students..."

students = User.create!([
  { first_name: "Alice",   last_name: "Johnson",  email: "alice.johnson@student.edu",
    role: "student", student_id: "S1001" },
  { first_name: "Bob",     last_name: "Martinez", email: "bob.martinez@student.edu",
    role: "student", student_id: "S1002" },
  { first_name: "Carol",   last_name: "Williams", email: "carol.williams@student.edu",
    role: "student", student_id: "S1003" },
  { first_name: "David",   last_name: "Brown",    email: "david.brown@student.edu",
    role: "student", student_id: "S1004" },
  { first_name: "Eva",     last_name: "Davis",    email: "eva.davis@student.edu",
    role: "student", student_id: "S1005" },
  { first_name: "Frank",   last_name: "Wilson",   email: "frank.wilson@student.edu",
    role: "student", student_id: "S1006" },
  { first_name: "Grace",   last_name: "Taylor",   email: "grace.taylor@student.edu",
    role: "student", student_id: "S1007" },
  { first_name: "Henry",   last_name: "Anderson", email: "henry.anderson@student.edu",
    role: "student", student_id: "S1008" },
  { first_name: "Iris",    last_name: "Thomas",   email: "iris.thomas@student.edu",
    role: "student", student_id: "S1009" },
  { first_name: "James",   last_name: "Jackson",  email: "james.jackson@student.edu",
    role: "student", student_id: "S1010" }
])

alice, bob, carol, david, eva, frank, grace, henry, iris, james = students

# ─── Class Sessions ──────────────────────────────────────────────────────────

puts "Creating class sessions..."

# Convenience lookup
course = courses.index_by(&:code)

# Fall 2026 sessions
fall_sessions = ClassSession.create!([
  { course: course["ENG101"],  semester: fall2026, teacher: t_atwood,
    room: "Humanities 101", schedule: "MWF 9:00-9:50am",   max_enrollment: 25 },
  { course: course["MATH101"], semester: fall2026, teacher: t_feynman,
    room: "Science Hall 210", schedule: "MWF 10:00-10:50am", max_enrollment: 30 },
  { course: course["SCI101"],  semester: fall2026, teacher: t_sagan,
    room: "Science Hall 105", schedule: "TTh 9:30-10:45am",  max_enrollment: 28 },
  { course: course["HIST101"], semester: fall2026, teacher: t_zinn,
    room: "Social Sciences 301", schedule: "MWF 11:00-11:50am", max_enrollment: 35 },
  { course: course["CS101"],   semester: fall2026, teacher: t_lovelace,
    room: "Tech Building 201", schedule: "TTh 11:00-12:15pm", max_enrollment: 30 },
  { course: course["MATH210"], semester: fall2026, teacher: t_feynman,
    room: "Science Hall 212", schedule: "TTh 1:00-2:15pm",   max_enrollment: 30 },
  { course: course["ENG201"],  semester: fall2026, teacher: t_atwood,
    room: "Humanities 103", schedule: "MWF 1:00-1:50pm",    max_enrollment: 25 },
  { course: course["CS201"],   semester: fall2026, teacher: t_hopper,
    room: "Tech Building 205", schedule: "MWF 2:00-2:50pm",  max_enrollment: 28 }
])

# Spring 2027 sessions
spring_sessions = ClassSession.create!([
  { course: course["ENG310"],  semester: spring2027, teacher: t_atwood,
    room: "Humanities 102", schedule: "TTh 9:30-10:45am",   max_enrollment: 20 },
  { course: course["MATH201"], semester: spring2027, teacher: t_feynman,
    room: "Science Hall 211", schedule: "MWF 9:00-9:50am",  max_enrollment: 30 },
  { course: course["SCI110"],  semester: spring2027, teacher: t_sagan,
    room: "Science Hall 106", schedule: "MWF 10:00-10:50am", max_enrollment: 28 },
  { course: course["HIST201"], semester: spring2027, teacher: t_zinn,
    room: "Social Sciences 302", schedule: "TTh 11:00-12:15pm", max_enrollment: 35 },
  { course: course["CS310"],   semester: spring2027, teacher: t_hopper,
    room: "Tech Building 202", schedule: "MWF 11:00-11:50am", max_enrollment: 25 },
  { course: course["SCI120"],  semester: spring2027, teacher: t_feynman,
    room: "Science Hall 120", schedule: "TTh 1:00-2:15pm",  max_enrollment: 30 },
  { course: course["CS201"],   semester: spring2027, teacher: t_lovelace,
    room: "Tech Building 206", schedule: "MWF 2:00-2:50pm", max_enrollment: 28 },
  { course: course["ENG201"],  semester: spring2027, teacher: t_atwood,
    room: "Humanities 104", schedule: "TTh 3:00-4:15pm",    max_enrollment: 25 }
])

all_sessions = fall_sessions + spring_sessions

# ─── Enrollments ─────────────────────────────────────────────────────────────

puts "Creating enrollments..."

# Helper: enroll a student in a session with a grade
def enroll(student, session, grade: nil, status: "enrolled")
  Enrollment.create!(
    student: student,
    class_session: session,
    grade: grade,
    status: status
  )
end

# Fall 2026 grades (completed)
fall_eng101, fall_math101, fall_sci101, fall_hist101, fall_cs101,
fall_math210, fall_eng201, fall_cs201 = fall_sessions

enroll(alice,  fall_eng101,  grade: "A",  status: "completed")
enroll(alice,  fall_math101, grade: "B+", status: "completed")
enroll(alice,  fall_cs101,   grade: "A-", status: "completed")
enroll(alice,  fall_hist101, grade: "B",  status: "completed")

enroll(bob,    fall_eng101,  grade: "B-", status: "completed")
enroll(bob,    fall_math101, grade: "C+", status: "completed")
enroll(bob,    fall_sci101,  grade: "B",  status: "completed")
enroll(bob,    fall_cs101,   grade: "A",  status: "completed")

enroll(carol,  fall_math101, grade: "A",  status: "completed")
enroll(carol,  fall_sci101,  grade: "A-", status: "completed")
enroll(carol,  fall_math210, grade: "B+", status: "completed")
enroll(carol,  fall_cs201,   grade: "A",  status: "completed")

enroll(david,  fall_hist101, grade: "A-", status: "completed")
enroll(david,  fall_eng201,  grade: "B+", status: "completed")
enroll(david,  fall_eng101,  grade: "B",  status: "completed")

enroll(eva,    fall_cs101,   grade: "A",  status: "completed")
enroll(eva,    fall_cs201,   grade: "A-", status: "completed")
enroll(eva,    fall_math101, grade: "B+", status: "completed")

enroll(frank,  fall_sci101,  grade: "C+", status: "completed")
enroll(frank,  fall_math101, grade: "C",  status: "completed")
enroll(frank,  fall_hist101, grade: "B-", status: "completed")

enroll(grace,  fall_eng101,  grade: "A-", status: "completed")
enroll(grace,  fall_eng201,  grade: "A",  status: "completed")
enroll(grace,  fall_hist101, grade: "B+", status: "completed")

enroll(henry,  fall_math101, grade: "D+", status: "completed")
enroll(henry,  fall_sci101,  grade: "C",  status: "completed")
enroll(henry,  fall_cs101,   grade: "B-", status: "completed")

enroll(iris,   fall_math210, grade: "A",  status: "completed")
enroll(iris,   fall_cs201,   grade: "B+", status: "completed")
enroll(iris,   fall_sci101,  grade: "A-", status: "completed")

enroll(james,  fall_hist101, grade: "B",  status: "completed")
enroll(james,  fall_eng101,  grade: "C+", status: "completed")
enroll(james,  fall_cs101,   grade: "B+", status: "completed")

# Spring 2027 enrollments (in progress — no grades yet)
spr_eng310, spr_math201, spr_sci110, spr_hist201, spr_cs310,
spr_sci120, spr_cs201, spr_eng201 = spring_sessions

enroll(alice,  spr_eng310)
enroll(alice,  spr_math201)
enroll(alice,  spr_cs310)

enroll(bob,    spr_sci110)
enroll(bob,    spr_cs310)
enroll(bob,    spr_hist201)

enroll(carol,  spr_math201)
enroll(carol,  spr_sci110)
enroll(carol,  spr_cs201)

enroll(david,  spr_hist201)
enroll(david,  spr_eng201)

enroll(eva,    spr_cs201)
enroll(eva,    spr_cs310)
enroll(eva,    spr_math201)

enroll(frank,  spr_sci110)
enroll(frank,  spr_sci120)

enroll(grace,  spr_eng310)
enroll(grace,  spr_eng201)

enroll(henry,  spr_sci120)
enroll(henry,  spr_math201)

enroll(iris,   spr_cs201)
enroll(iris,   spr_sci110)

enroll(james,  spr_hist201)
enroll(james,  spr_cs310)

puts ""
puts "✅ Seed complete!"
puts "   #{Department.count} departments"
puts "   #{Course.count} courses"
puts "   #{Semester.count} semesters"
puts "   #{User.teachers.count} teachers"
puts "   #{User.students.count} students"
puts "   #{ClassSession.count} class sessions"
puts "   #{Enrollment.count} enrollments"
