# db/seeds.rb
# Clears existing data and seeds the school database

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Course.destroy_all
Department.destroy_all
Semester.destroy_all
User.destroy_all

# ── Departments ──────────────────────────────────────────────────────────────
puts "Creating departments..."
english    = Department.create!(name: "English")
math       = Department.create!(name: "Math")
science    = Department.create!(name: "Science")
history    = Department.create!(name: "History")
cs_dept    = Department.create!(name: "Computer Science")

# ── Semesters ────────────────────────────────────────────────────────────────
puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-09-01", end_date: "2026-12-20")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-15", end_date: "2027-05-10")

# ── Courses ───────────────────────────────────────────────────────────────────
puts "Creating courses..."
# English
eng101 = Course.create!(name: "Composition I",          code: "ENG101", department: english)
eng201 = Course.create!(name: "American Literature",     code: "ENG201", department: english)

# Math
mat101 = Course.create!(name: "Algebra",                code: "MAT101", department: math)
mat201 = Course.create!(name: "Calculus I",             code: "MAT201", department: math)

# Science
sci101 = Course.create!(name: "Biology",                code: "SCI101", department: science)
sci201 = Course.create!(name: "Chemistry",              code: "SCI201", department: science)

# History
his101 = Course.create!(name: "World History",          code: "HIS101", department: history)
his201 = Course.create!(name: "US History",             code: "HIS201", department: history)

# Computer Science
cs101  = Course.create!(name: "Intro to Programming",   code: "CS101",  department: cs_dept)
cs201  = Course.create!(name: "Data Structures",        code: "CS201",  department: cs_dept)

# ── Teachers ──────────────────────────────────────────────────────────────────
puts "Creating teachers..."
t_smith   = User.create!(name: "Alice Smith",   email: "alice.smith@school.edu",   role: "teacher")
t_jones   = User.create!(name: "Bob Jones",     email: "bob.jones@school.edu",     role: "teacher")
t_patel   = User.create!(name: "Priya Patel",   email: "priya.patel@school.edu",   role: "teacher")
t_nguyen  = User.create!(name: "David Nguyen",  email: "david.nguyen@school.edu",  role: "teacher")
t_garcia  = User.create!(name: "Maria Garcia",  email: "maria.garcia@school.edu",  role: "teacher")

# ── Students ──────────────────────────────────────────────────────────────────
puts "Creating students..."
students = [
  User.create!(name: "Emma Johnson",   email: "emma.johnson@students.edu",   role: "student"),
  User.create!(name: "Liam Williams",  email: "liam.williams@students.edu",  role: "student"),
  User.create!(name: "Olivia Brown",   email: "olivia.brown@students.edu",   role: "student"),
  User.create!(name: "Noah Davis",     email: "noah.davis@students.edu",     role: "student"),
  User.create!(name: "Ava Miller",     email: "ava.miller@students.edu",     role: "student"),
  User.create!(name: "Ethan Wilson",   email: "ethan.wilson@students.edu",   role: "student"),
  User.create!(name: "Sophia Moore",   email: "sophia.moore@students.edu",   role: "student"),
  User.create!(name: "Mason Taylor",   email: "mason.taylor@students.edu",   role: "student"),
]

# ── Class Sessions ────────────────────────────────────────────────────────────
puts "Creating class sessions..."

# Fall 2026
cs_eng101_f26  = ClassSession.create!(course: eng101, semester: fall2026,   teacher: t_smith)
cs_mat101_f26  = ClassSession.create!(course: mat101, semester: fall2026,   teacher: t_jones)
cs_sci101_f26  = ClassSession.create!(course: sci101, semester: fall2026,   teacher: t_patel)
cs_his101_f26  = ClassSession.create!(course: his101, semester: fall2026,   teacher: t_nguyen)
cs_cs101_f26   = ClassSession.create!(course: cs101,  semester: fall2026,   teacher: t_garcia)

# Spring 2027
cs_eng201_s27  = ClassSession.create!(course: eng201, semester: spring2027, teacher: t_smith)
cs_mat201_s27  = ClassSession.create!(course: mat201, semester: spring2027, teacher: t_jones)
cs_sci201_s27  = ClassSession.create!(course: sci201, semester: spring2027, teacher: t_patel)
cs_his201_s27  = ClassSession.create!(course: his201, semester: spring2027, teacher: t_nguyen)
cs_cs201_s27   = ClassSession.create!(course: cs201,  semester: spring2027, teacher: t_garcia)

# ── Enrollments (students → class sessions with grades) ───────────────────────
puts "Creating enrollments..."

grades = %w[A A- B+ B B- C+ C]

# Enroll each student in a handful of sessions with random grades
enrollment_map = {
  students[0] => [cs_eng101_f26, cs_mat101_f26, cs_sci101_f26, cs_eng201_s27, cs_mat201_s27],
  students[1] => [cs_mat101_f26, cs_his101_f26, cs_cs101_f26,  cs_mat201_s27, cs_cs201_s27],
  students[2] => [cs_eng101_f26, cs_sci101_f26, cs_his101_f26, cs_sci201_s27, cs_his201_s27],
  students[3] => [cs_cs101_f26,  cs_mat101_f26, cs_eng101_f26, cs_cs201_s27,  cs_eng201_s27],
  students[4] => [cs_sci101_f26, cs_his101_f26, cs_eng101_f26, cs_sci201_s27, cs_his201_s27],
  students[5] => [cs_mat101_f26, cs_cs101_f26,  cs_sci101_f26, cs_mat201_s27, cs_cs201_s27],
  students[6] => [cs_his101_f26, cs_eng101_f26, cs_mat101_f26, cs_his201_s27, cs_eng201_s27],
  students[7] => [cs_cs101_f26,  cs_his101_f26, cs_sci101_f26, cs_cs201_s27,  cs_sci201_s27],
}

enrollment_map.each do |student, sessions|
  sessions.each_with_index do |session, i|
    # Fall sessions get a grade; spring sessions are still in progress (nil grade)
    grade = session.semester == fall2026 ? grades[i % grades.length] : nil
    Enrollment.create!(class_session: session, student: student, grade: grade)
  end
end

puts "Done! Seeded:"
puts "  #{Department.count} departments"
puts "  #{Semester.count} semesters"
puts "  #{Course.count} courses"
puts "  #{User.teachers.count} teachers"
puts "  #{User.students.count} students"
puts "  #{ClassSession.count} class sessions"
puts "  #{Enrollment.count} enrollments"
