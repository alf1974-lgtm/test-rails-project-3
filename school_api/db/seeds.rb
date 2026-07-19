# db/seeds.rb
# Clears existing data and seeds the school database.

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Course.destroy_all
Department.destroy_all
Semester.destroy_all
User.destroy_all

# ── Semesters ────────────────────────────────────────────────────────────────
puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026")
spring2027 = Semester.create!(name: "Spring 2027")

# ── Departments ───────────────────────────────────────────────────────────────
puts "Creating departments..."
english  = Department.create!(name: "English")
math     = Department.create!(name: "Math")
science  = Department.create!(name: "Science")
history  = Department.create!(name: "History")
cs       = Department.create!(name: "Computer Science")

# ── Courses ───────────────────────────────────────────────────────────────────
puts "Creating courses..."
# English
eng101 = Course.create!(name: "Composition I",          code: "ENG101", department: english)
eng201 = Course.create!(name: "American Literature",    code: "ENG201", department: english)

# Math
mat101 = Course.create!(name: "Calculus I",             code: "MAT101", department: math)
mat201 = Course.create!(name: "Linear Algebra",         code: "MAT201", department: math)

# Science
sci101 = Course.create!(name: "Biology I",              code: "SCI101", department: science)
sci201 = Course.create!(name: "Chemistry I",            code: "SCI201", department: science)

# History
his101 = Course.create!(name: "World History",          code: "HIS101", department: history)
his201 = Course.create!(name: "US History",             code: "HIS201", department: history)

# Computer Science
cs101  = Course.create!(name: "Intro to Programming",  code: "CS101",  department: cs)
cs201  = Course.create!(name: "Data Structures",       code: "CS201",  department: cs)

# ── Teachers ──────────────────────────────────────────────────────────────────
puts "Creating teachers..."
teachers = [
  { name: "Dr. Alice Nguyen",   email: "alice.nguyen@school.edu",   role: "teacher" },
  { name: "Prof. Bob Martinez", email: "bob.martinez@school.edu",   role: "teacher" },
  { name: "Dr. Carol Smith",    email: "carol.smith@school.edu",    role: "teacher" },
  { name: "Prof. David Lee",    email: "david.lee@school.edu",      role: "teacher" },
  { name: "Dr. Eva Brown",      email: "eva.brown@school.edu",      role: "teacher" }
].map { |attrs| User.create!(attrs) }

alice, bob, carol, david, eva = teachers

# ── Students ──────────────────────────────────────────────────────────────────
puts "Creating students..."
students = [
  { name: "Jordan Rivera",   email: "jordan.rivera@students.edu",   role: "student" },
  { name: "Sam Patel",       email: "sam.patel@students.edu",       role: "student" },
  { name: "Taylor Kim",      email: "taylor.kim@students.edu",      role: "student" },
  { name: "Morgan Chen",     email: "morgan.chen@students.edu",     role: "student" },
  { name: "Casey Johnson",   email: "casey.johnson@students.edu",   role: "student" },
  { name: "Riley Thompson",  email: "riley.thompson@students.edu",  role: "student" },
  { name: "Avery Williams",  email: "avery.williams@students.edu",  role: "student" },
  { name: "Quinn Davis",     email: "quinn.davis@students.edu",     role: "student" }
].map { |attrs| User.create!(attrs) }

jordan, sam, taylor, morgan, casey, riley, avery, quinn = students

# ── Class Sessions ────────────────────────────────────────────────────────────
puts "Creating class sessions..."

# Fall 2026
cs_eng101_f26  = ClassSession.create!(course: eng101, semester: fall2026,   teacher: alice)
cs_mat101_f26  = ClassSession.create!(course: mat101, semester: fall2026,   teacher: bob)
cs_sci101_f26  = ClassSession.create!(course: sci101, semester: fall2026,   teacher: carol)
cs_his101_f26  = ClassSession.create!(course: his101, semester: fall2026,   teacher: david)
cs_cs101_f26   = ClassSession.create!(course: cs101,  semester: fall2026,   teacher: eva)

# Spring 2027
cs_eng201_s27  = ClassSession.create!(course: eng201, semester: spring2027, teacher: alice)
cs_mat201_s27  = ClassSession.create!(course: mat201, semester: spring2027, teacher: bob)
cs_sci201_s27  = ClassSession.create!(course: sci201, semester: spring2027, teacher: carol)
cs_his201_s27  = ClassSession.create!(course: his201, semester: spring2027, teacher: david)
cs_cs201_s27   = ClassSession.create!(course: cs201,  semester: spring2027, teacher: eva)

# ── Enrollments (with grades for Fall 2026, pending for Spring 2027) ──────────
puts "Creating enrollments..."

grades = %w[A A- B+ B B- C+ C]

[
  # Jordan: CS + Math focus
  [ jordan, cs_cs101_f26,  "A"  ],
  [ jordan, cs_mat101_f26, "A-" ],
  [ jordan, cs_eng101_f26, "B+" ],
  [ jordan, cs_cs201_s27,  nil  ],
  [ jordan, cs_mat201_s27, nil  ],

  # Sam: Science + History focus
  [ sam, cs_sci101_f26,  "B"  ],
  [ sam, cs_his101_f26,  "A"  ],
  [ sam, cs_eng101_f26,  "B-" ],
  [ sam, cs_sci201_s27,  nil  ],
  [ sam, cs_his201_s27,  nil  ],

  # Taylor: English + History
  [ taylor, cs_eng101_f26, "A"  ],
  [ taylor, cs_his101_f26, "A-" ],
  [ taylor, cs_mat101_f26, "C+" ],
  [ taylor, cs_eng201_s27, nil  ],
  [ taylor, cs_his201_s27, nil  ],

  # Morgan: CS + Science
  [ morgan, cs_cs101_f26,  "B+" ],
  [ morgan, cs_sci101_f26, "A-" ],
  [ morgan, cs_mat101_f26, "B"  ],
  [ morgan, cs_cs201_s27,  nil  ],
  [ morgan, cs_sci201_s27, nil  ],

  # Casey: broad schedule
  [ casey, cs_eng101_f26, "B"  ],
  [ casey, cs_mat101_f26, "B-" ],
  [ casey, cs_his101_f26, "A-" ],
  [ casey, cs_eng201_s27, nil  ],
  [ casey, cs_mat201_s27, nil  ],

  # Riley: science heavy
  [ riley, cs_sci101_f26, "A"  ],
  [ riley, cs_cs101_f26,  "B+" ],
  [ riley, cs_sci201_s27, nil  ],
  [ riley, cs_cs201_s27,  nil  ],

  # Avery: history + english
  [ avery, cs_his101_f26, "B"  ],
  [ avery, cs_eng101_f26, "A-" ],
  [ avery, cs_his201_s27, nil  ],
  [ avery, cs_eng201_s27, nil  ],

  # Quinn: math + CS
  [ quinn, cs_mat101_f26, "A"  ],
  [ quinn, cs_cs101_f26,  "A-" ],
  [ quinn, cs_mat201_s27, nil  ],
  [ quinn, cs_cs201_s27,  nil  ]
].each do |student, session, grade|
  Enrollment.create!(student: student, class_session: session, grade: grade)
end

puts ""
puts "✅  Seed complete!"
puts "   #{User.teachers.count} teachers, #{User.students.count} students"
puts "   #{Department.count} departments, #{Course.count} courses"
puts "   #{Semester.count} semesters, #{ClassSession.count} class sessions"
puts "   #{Enrollment.count} enrollments"
