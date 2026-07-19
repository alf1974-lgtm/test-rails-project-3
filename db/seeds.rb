# db/seeds.rb
# -------------------------------------------------------
# Departments
# -------------------------------------------------------
puts "Seeding departments..."
english    = Department.find_or_create_by!(name: "English")
math       = Department.find_or_create_by!(name: "Math")
science    = Department.find_or_create_by!(name: "Science")
history    = Department.find_or_create_by!(name: "History")

# -------------------------------------------------------
# Courses
# -------------------------------------------------------
puts "Seeding courses..."
eng101  = Course.find_or_create_by!(name: "English 101",        department: english)
eng201  = Course.find_or_create_by!(name: "Creative Writing",   department: english)
mat101  = Course.find_or_create_by!(name: "Algebra I",          department: math)
mat201  = Course.find_or_create_by!(name: "Calculus",           department: math)
sci101  = Course.find_or_create_by!(name: "Biology",            department: science)
sci201  = Course.find_or_create_by!(name: "Chemistry",          department: science)
his101  = Course.find_or_create_by!(name: "World History",      department: history)
his201  = Course.find_or_create_by!(name: "US History",         department: history)

# -------------------------------------------------------
# Semesters
# -------------------------------------------------------
puts "Seeding semesters..."
fall2026   = Semester.find_or_create_by!(name: "Fall 2026")
spring2027 = Semester.find_or_create_by!(name: "Spring 2027")

# -------------------------------------------------------
# Teachers
# -------------------------------------------------------
puts "Seeding teachers..."
teachers = [
  { name: "Ms. Alice Johnson",  email: "alice.johnson@school.edu",  role: "teacher" },
  { name: "Mr. Bob Williams",   email: "bob.williams@school.edu",   role: "teacher" },
  { name: "Dr. Carol Martinez", email: "carol.martinez@school.edu", role: "teacher" },
  { name: "Mr. David Lee",      email: "david.lee@school.edu",      role: "teacher" },
].map { |attrs| User.find_or_create_by!(email: attrs[:email]) { |u| u.assign_attributes(attrs) } }

alice, bob, carol, david = teachers

# -------------------------------------------------------
# Students
# -------------------------------------------------------
puts "Seeding students..."
student_data = [
  { name: "Emma Thompson",   email: "emma.thompson@students.edu"   },
  { name: "Liam Garcia",     email: "liam.garcia@students.edu"     },
  { name: "Olivia Brown",    email: "olivia.brown@students.edu"    },
  { name: "Noah Davis",      email: "noah.davis@students.edu"      },
  { name: "Ava Wilson",      email: "ava.wilson@students.edu"      },
  { name: "Elijah Moore",    email: "elijah.moore@students.edu"    },
  { name: "Sophia Taylor",   email: "sophia.taylor@students.edu"   },
  { name: "James Anderson",  email: "james.anderson@students.edu"  },
  { name: "Isabella Thomas", email: "isabella.thomas@students.edu" },
  { name: "Oliver Jackson",  email: "oliver.jackson@students.edu"  },
]

students = student_data.map do |attrs|
  User.find_or_create_by!(email: attrs[:email]) { |u| u.assign_attributes(attrs.merge(role: "student")) }
end

emma, liam, olivia, noah, ava, elijah, sophia, james, isabella, oliver = students

# -------------------------------------------------------
# Class Sessions
# -------------------------------------------------------
puts "Seeding class sessions..."

# Fall 2026
eng101_fall   = ClassSession.find_or_create_by!(course: eng101,  semester: fall2026,   teacher: alice)
mat101_fall   = ClassSession.find_or_create_by!(course: mat101,  semester: fall2026,   teacher: bob)
sci101_fall   = ClassSession.find_or_create_by!(course: sci101,  semester: fall2026,   teacher: carol)
his101_fall   = ClassSession.find_or_create_by!(course: his101,  semester: fall2026,   teacher: david)
eng201_fall   = ClassSession.find_or_create_by!(course: eng201,  semester: fall2026,   teacher: alice)
mat201_fall   = ClassSession.find_or_create_by!(course: mat201,  semester: fall2026,   teacher: bob)

# Spring 2027
sci201_spring = ClassSession.find_or_create_by!(course: sci201,  semester: spring2027, teacher: carol)
his201_spring = ClassSession.find_or_create_by!(course: his201,  semester: spring2027, teacher: david)
eng101_spring = ClassSession.find_or_create_by!(course: eng101,  semester: spring2027, teacher: alice)
mat101_spring = ClassSession.find_or_create_by!(course: mat101,  semester: spring2027, teacher: bob)

# -------------------------------------------------------
# Enrollments  (student => class_session, grade)
# -------------------------------------------------------
puts "Seeding enrollments..."

grades = %w[A A B B C]

enrollments = [
  # Fall 2026 — English 101
  [emma,     eng101_fall,   "A"],
  [liam,     eng101_fall,   "B"],
  [olivia,   eng101_fall,   "A"],
  [noah,     eng101_fall,   "C"],
  [ava,      eng101_fall,   "B"],

  # Fall 2026 — Algebra I
  [liam,     mat101_fall,   "A"],
  [noah,     mat101_fall,   "B"],
  [elijah,   mat101_fall,   "A"],
  [sophia,   mat101_fall,   "C"],
  [james,    mat101_fall,   "B"],

  # Fall 2026 — Biology
  [emma,     sci101_fall,   "B"],
  [olivia,   sci101_fall,   "A"],
  [ava,      sci101_fall,   "A"],
  [isabella, sci101_fall,   "B"],
  [oliver,   sci101_fall,   "C"],

  # Fall 2026 — World History
  [sophia,   his101_fall,   "A"],
  [james,    his101_fall,   "B"],
  [isabella, his101_fall,   "A"],
  [oliver,   his101_fall,   "B"],
  [elijah,   his101_fall,   "C"],

  # Fall 2026 — Creative Writing
  [emma,     eng201_fall,   "A"],
  [olivia,   eng201_fall,   "B"],
  [ava,      eng201_fall,   "A"],

  # Fall 2026 — Calculus
  [liam,     mat201_fall,   "B"],
  [noah,     mat201_fall,   "A"],
  [elijah,   mat201_fall,   "B"],

  # Spring 2027 — Chemistry
  [emma,     sci201_spring, "A"],
  [liam,     sci201_spring, "B"],
  [olivia,   sci201_spring, "A"],
  [noah,     sci201_spring, "C"],

  # Spring 2027 — US History
  [sophia,   his201_spring, "B"],
  [james,    his201_spring, "A"],
  [isabella, his201_spring, "B"],
  [oliver,   his201_spring, "A"],

  # Spring 2027 — English 101 (second run)
  [elijah,   eng101_spring, "B"],
  [james,    eng101_spring, "A"],

  # Spring 2027 — Algebra I (second run)
  [ava,      mat101_spring, "A"],
  [sophia,   mat101_spring, "B"],
  [oliver,   mat101_spring, "C"],
]

enrollments.each do |student, session, grade|
  Enrollment.find_or_create_by!(class_session: session, student: student) do |e|
    e.grade = grade
  end
end

puts "Done! Seeded:"
puts "  #{Department.count} departments"
puts "  #{Course.count} courses"
puts "  #{Semester.count} semesters"
puts "  #{User.where(role: 'teacher').count} teachers"
puts "  #{User.where(role: 'student').count} students"
puts "  #{ClassSession.count} class sessions"
puts "  #{Enrollment.count} enrollments"
