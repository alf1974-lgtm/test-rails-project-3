# Clear existing data
puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Course.destroy_all
Department.destroy_all
Semester.destroy_all
User.destroy_all

# ── Semesters ──────────────────────────────────────────────────────────────
puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   season: "Fall",   year: 2026)
spring2027 = Semester.create!(name: "Spring 2027", season: "Spring", year: 2027)

# ── Departments ────────────────────────────────────────────────────────────
puts "Creating departments..."
english  = Department.create!(name: "English",  description: "Language, literature, and writing")
math     = Department.create!(name: "Math",     description: "Mathematics and statistics")
science  = Department.create!(name: "Science",  description: "Natural sciences")
history  = Department.create!(name: "History",  description: "World and American history")

# ── Teachers ───────────────────────────────────────────────────────────────
puts "Creating teachers..."
t_smith   = User.create!(name: "Alice Smith",   email: "alice.smith@school.edu",   role: "teacher")
t_jones   = User.create!(name: "Bob Jones",     email: "bob.jones@school.edu",     role: "teacher")
t_patel   = User.create!(name: "Priya Patel",   email: "priya.patel@school.edu",   role: "teacher")
t_nguyen  = User.create!(name: "David Nguyen",  email: "david.nguyen@school.edu",  role: "teacher")

# ── Students ───────────────────────────────────────────────────────────────
puts "Creating students..."
students = [
  { name: "Emma Johnson",   email: "emma.johnson@school.edu"   },
  { name: "Liam Williams",  email: "liam.williams@school.edu"  },
  { name: "Olivia Brown",   email: "olivia.brown@school.edu"   },
  { name: "Noah Davis",     email: "noah.davis@school.edu"     },
  { name: "Ava Miller",     email: "ava.miller@school.edu"     },
  { name: "Elijah Wilson",  email: "elijah.wilson@school.edu"  },
  { name: "Sophia Moore",   email: "sophia.moore@school.edu"   },
  { name: "James Taylor",   email: "james.taylor@school.edu"   },
  { name: "Isabella Anderson", email: "isabella.anderson@school.edu" },
  { name: "Oliver Thomas", email: "oliver.thomas@school.edu"  },
].map { |attrs| User.create!(attrs.merge(role: "student")) }

# ── Courses ────────────────────────────────────────────────────────────────
puts "Creating courses..."
eng101  = Course.create!(name: "English Composition",  code: "ENG101", department: english,  description: "Fundamentals of academic writing")
eng201  = Course.create!(name: "American Literature",  code: "ENG201", department: english,  description: "Survey of American literary works")
mat101  = Course.create!(name: "Calculus I",           code: "MAT101", department: math,     description: "Limits, derivatives, and integrals")
mat201  = Course.create!(name: "Linear Algebra",       code: "MAT201", department: math,     description: "Vectors, matrices, and linear transformations")
sci101  = Course.create!(name: "Biology",              code: "SCI101", department: science,  description: "Introduction to life sciences")
sci201  = Course.create!(name: "Chemistry",            code: "SCI201", department: science,  description: "General chemistry principles")
his101  = Course.create!(name: "World History",        code: "HIS101", department: history,  description: "Survey of world history")
his201  = Course.create!(name: "American History",     code: "HIS201", department: history,  description: "United States history from founding to present")

# ── Class Sessions (Fall 2026) ─────────────────────────────────────────────
puts "Creating class sessions for Fall 2026..."
cs_eng101_f26  = ClassSession.create!(course: eng101, semester: fall2026,   teacher: t_smith)
cs_mat101_f26  = ClassSession.create!(course: mat101, semester: fall2026,   teacher: t_jones)
cs_sci101_f26  = ClassSession.create!(course: sci101, semester: fall2026,   teacher: t_patel)
cs_his101_f26  = ClassSession.create!(course: his101, semester: fall2026,   teacher: t_nguyen)

# ── Class Sessions (Spring 2027) ───────────────────────────────────────────
puts "Creating class sessions for Spring 2027..."
cs_eng201_s27  = ClassSession.create!(course: eng201, semester: spring2027, teacher: t_smith)
cs_mat201_s27  = ClassSession.create!(course: mat201, semester: spring2027, teacher: t_jones)
cs_sci201_s27  = ClassSession.create!(course: sci201, semester: spring2027, teacher: t_patel)
cs_his201_s27  = ClassSession.create!(course: his201, semester: spring2027, teacher: t_nguyen)

# ── Enrollments ────────────────────────────────────────────────────────────
puts "Creating enrollments..."
grades = %w[A A- B+ B B- C+ C]

# Fall 2026 enrollments
[cs_eng101_f26, cs_mat101_f26, cs_sci101_f26, cs_his101_f26].each do |session|
  students.sample(6).each do |student|
    Enrollment.find_or_create_by!(class_session: session, student: student) do |e|
      e.grade = grades.sample
    end
  end
end

# Spring 2027 enrollments
[cs_eng201_s27, cs_mat201_s27, cs_sci201_s27, cs_his201_s27].each do |session|
  students.sample(6).each do |student|
    Enrollment.find_or_create_by!(class_session: session, student: student) do |e|
      e.grade = nil  # grades not yet assigned for Spring 2027
    end
  end
end

puts "\nSeed complete!"
puts "  #{Semester.count} semesters"
puts "  #{Department.count} departments"
puts "  #{Course.count} courses"
puts "  #{User.where(role: 'teacher').count} teachers"
puts "  #{User.where(role: 'student').count} students"
puts "  #{ClassSession.count} class sessions"
puts "  #{Enrollment.count} enrollments"
