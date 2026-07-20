# db/seeds.rb
# Run with: rails db:seed
# Clears existing data and repopulates.

puts "Seeding database..."

# ── Clean up ──────────────────────────────────────────────────────────────────
Enrollment.destroy_all
ClassSession.destroy_all
Enrollment.destroy_all
Course.destroy_all
Department.destroy_all
Semester.destroy_all
User.destroy_all

# ── Departments ───────────────────────────────────────────────────────────────
departments = Department.create!([
  { name: "English",     description: "Literature, writing, and language arts" },
  { name: "Mathematics", description: "Algebra, calculus, statistics, and more" },
  { name: "Science",     description: "Biology, chemistry, physics, and earth science" },
  { name: "History",     description: "World, US, and regional history" },
  { name: "Computer Science", description: "Programming, algorithms, and systems" }
])

english  = departments.find { |d| d.name == "English" }
math     = departments.find { |d| d.name == "Mathematics" }
science  = departments.find { |d| d.name == "Science" }
history  = departments.find { |d| d.name == "History" }
cs       = departments.find { |d| d.name == "Computer Science" }

puts "  Created #{Department.count} departments"

# ── Courses ───────────────────────────────────────────────────────────────────
courses = Course.create!([
  # English
  { name: "Introduction to Literature",  course_code: "ENG101", credits: 3, department: english,
    description: "Survey of major literary works from antiquity to the modern era." },
  { name: "Composition and Rhetoric",    course_code: "ENG102", credits: 3, department: english,
    description: "Fundamentals of academic writing and argumentation." },
  { name: "American Literature",         course_code: "ENG201", credits: 3, department: english,
    description: "From colonial writing to contemporary American fiction." },

  # Math
  { name: "Pre-Calculus",                course_code: "MTH101", credits: 3, department: math,
    description: "Functions, trigonometry, and preparation for calculus." },
  { name: "Calculus I",                  course_code: "MTH201", credits: 4, department: math,
    description: "Limits, derivatives, and an introduction to integration." },
  { name: "Statistics",                  course_code: "MTH210", credits: 3, department: math,
    description: "Descriptive and inferential statistics with real-world applications." },

  # Science
  { name: "Biology I",                   course_code: "SCI101", credits: 4, department: science,
    description: "Cell biology, genetics, and evolution." },
  { name: "Chemistry I",                 course_code: "SCI102", credits: 4, department: science,
    description: "Atomic structure, bonding, and chemical reactions." },
  { name: "Physics I",                   course_code: "SCI201", credits: 4, department: science,
    description: "Mechanics, kinematics, and Newtonian dynamics." },

  # History
  { name: "World History",               course_code: "HIS101", credits: 3, department: history,
    description: "Major civilizations and events from prehistory to 1500 CE." },
  { name: "US History",                  course_code: "HIS201", credits: 3, department: history,
    description: "The United States from colonization through the 20th century." },

  # CS
  { name: "Intro to Programming",        course_code: "CS101",  credits: 3, department: cs,
    description: "Programming fundamentals using Python." },
  { name: "Data Structures",             course_code: "CS201",  credits: 3, department: cs,
    description: "Arrays, linked lists, trees, graphs, and algorithm analysis." },
  { name: "Web Development",             course_code: "CS301",  credits: 3, department: cs,
    description: "HTML, CSS, JavaScript, and intro to backend frameworks." }
])

puts "  Created #{Course.count} courses"

# ── Semesters ─────────────────────────────────────────────────────────────────
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-18")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-19", end_date: "2027-05-14")

puts "  Created #{Semester.count} semesters"

# ── Teachers ──────────────────────────────────────────────────────────────────
teachers = User.create!([
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu",     role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",      role: "teacher" }
])

atwood   = teachers.find { |t| t.last_name == "Atwood" }
feynman  = teachers.find { |t| t.last_name == "Feynman" }
lovelace = teachers.find { |t| t.last_name == "Lovelace" }
sagan    = teachers.find { |t| t.last_name == "Sagan" }
zinn     = teachers.find { |t| t.last_name == "Zinn" }

puts "  Created #{User.teachers.count} teachers"

# ── Students ──────────────────────────────────────────────────────────────────
student_data = [
  { first_name: "Alice",   last_name: "Johnson",   email: "alice.johnson@students.edu" },
  { first_name: "Bob",     last_name: "Smith",     email: "bob.smith@students.edu" },
  { first_name: "Carol",   last_name: "Williams",  email: "carol.williams@students.edu" },
  { first_name: "David",   last_name: "Brown",     email: "david.brown@students.edu" },
  { first_name: "Eva",     last_name: "Davis",     email: "eva.davis@students.edu" },
  { first_name: "Frank",   last_name: "Miller",    email: "frank.miller@students.edu" },
  { first_name: "Grace",   last_name: "Wilson",    email: "grace.wilson@students.edu" },
  { first_name: "Henry",   last_name: "Moore",     email: "henry.moore@students.edu" },
  { first_name: "Iris",    last_name: "Taylor",    email: "iris.taylor@students.edu" },
  { first_name: "James",   last_name: "Anderson",  email: "james.anderson@students.edu" },
  { first_name: "Karen",   last_name: "Thomas",    email: "karen.thomas@students.edu" },
  { first_name: "Leo",     last_name: "Jackson",   email: "leo.jackson@students.edu" }
]

students = User.create!(student_data.map { |s| s.merge(role: "student") })

alice  = students.find { |s| s.first_name == "Alice" }
bob    = students.find { |s| s.first_name == "Bob" }
carol  = students.find { |s| s.first_name == "Carol" }
david  = students.find { |s| s.first_name == "David" }
eva    = students.find { |s| s.first_name == "Eva" }
frank  = students.find { |s| s.first_name == "Frank" }
grace  = students.find { |s| s.first_name == "Grace" }
henry  = students.find { |s| s.first_name == "Henry" }
iris   = students.find { |s| s.first_name == "Iris" }
james  = students.find { |s| s.first_name == "James" }
karen  = students.find { |s| s.first_name == "Karen" }
leo    = students.find { |s| s.first_name == "Leo" }

puts "  Created #{User.students.count} students"

# ── Helper to look up a course by code ────────────────────────────────────────
def course(code)
  Course.find_by!(course_code: code)
end

# ── Class Sessions — Fall 2026 ────────────────────────────────────────────────
cs_eng101_f26  = ClassSession.create!(course: course("ENG101"), semester: fall2026,   teacher: atwood,   room: "Humanities 101", schedule: "MWF 9:00-9:50")
cs_eng102_f26  = ClassSession.create!(course: course("ENG102"), semester: fall2026,   teacher: atwood,   room: "Humanities 102", schedule: "TTh 10:30-11:45")
cs_mth201_f26  = ClassSession.create!(course: course("MTH201"), semester: fall2026,   teacher: feynman,  room: "Science 210",    schedule: "MWF 11:00-11:50")
cs_mth210_f26  = ClassSession.create!(course: course("MTH210"), semester: fall2026,   teacher: feynman,  room: "Science 211",    schedule: "TTh 1:00-2:15")
cs_sci101_f26  = ClassSession.create!(course: course("SCI101"), semester: fall2026,   teacher: sagan,    room: "Science 301",    schedule: "MWF 10:00-10:50")
cs_sci102_f26  = ClassSession.create!(course: course("SCI102"), semester: fall2026,   teacher: sagan,    room: "Science 302",    schedule: "TTh 8:00-9:15")
cs_his101_f26  = ClassSession.create!(course: course("HIS101"), semester: fall2026,   teacher: zinn,     room: "Social 105",     schedule: "MWF 2:00-2:50")
cs_cs101_f26   = ClassSession.create!(course: course("CS101"),  semester: fall2026,   teacher: lovelace, room: "Tech 201",       schedule: "TTh 3:00-4:15")
cs_cs201_f26   = ClassSession.create!(course: course("CS201"),  semester: fall2026,   teacher: lovelace, room: "Tech 202",       schedule: "MWF 3:00-3:50")

# ── Class Sessions — Spring 2027 ──────────────────────────────────────────────
cs_eng201_s27  = ClassSession.create!(course: course("ENG201"), semester: spring2027, teacher: atwood,   room: "Humanities 103", schedule: "MWF 9:00-9:50")
cs_mth101_s27  = ClassSession.create!(course: course("MTH101"), semester: spring2027, teacher: feynman,  room: "Science 210",    schedule: "TTh 10:30-11:45")
cs_sci201_s27  = ClassSession.create!(course: course("SCI201"), semester: spring2027, teacher: sagan,    room: "Science 303",    schedule: "MWF 11:00-11:50")
cs_his201_s27  = ClassSession.create!(course: course("HIS201"), semester: spring2027, teacher: zinn,     room: "Social 106",     schedule: "TTh 1:00-2:15")
cs_cs301_s27   = ClassSession.create!(course: course("CS301"),  semester: spring2027, teacher: lovelace, room: "Tech 203",       schedule: "MWF 2:00-2:50")
cs_mth210_s27  = ClassSession.create!(course: course("MTH210"), semester: spring2027, teacher: feynman,  room: "Science 211",    schedule: "TTh 3:00-4:15")

puts "  Created #{ClassSession.count} class sessions"

# ── Enrollments ───────────────────────────────────────────────────────────────
# Grades for Fall 2026 (already completed — all graded)
# Grades for Spring 2027 (in progress — some nil)

enrollments = [
  # Alice: CS student, strong in math
  { class_session: cs_cs101_f26,  student: alice, grade: "A"  },
  { class_session: cs_mth201_f26, student: alice, grade: "A-" },
  { class_session: cs_eng101_f26, student: alice, grade: "B+" },
  { class_session: cs_cs201_f26,  student: alice, grade: "A"  },
  { class_session: cs_cs301_s27,  student: alice, grade: nil  },
  { class_session: cs_mth210_s27, student: alice, grade: nil  },

  # Bob: history buff
  { class_session: cs_his101_f26, student: bob, grade: "A"  },
  { class_session: cs_eng101_f26, student: bob, grade: "B"  },
  { class_session: cs_mth210_f26, student: bob, grade: "C+" },
  { class_session: cs_his201_s27, student: bob, grade: nil  },
  { class_session: cs_eng201_s27, student: bob, grade: nil  },

  # Carol: science focus
  { class_session: cs_sci101_f26, student: carol, grade: "A-" },
  { class_session: cs_sci102_f26, student: carol, grade: "B+" },
  { class_session: cs_mth201_f26, student: carol, grade: "B"  },
  { class_session: cs_sci201_s27, student: carol, grade: nil  },
  { class_session: cs_mth101_s27, student: carol, grade: nil  },

  # David: well-rounded
  { class_session: cs_eng102_f26, student: david, grade: "B-" },
  { class_session: cs_his101_f26, student: david, grade: "A-" },
  { class_session: cs_sci101_f26, student: david, grade: "B"  },
  { class_session: cs_cs101_f26,  student: david, grade: "B+" },
  { class_session: cs_his201_s27, student: david, grade: nil  },
  { class_session: cs_cs301_s27,  student: david, grade: nil  },

  # Eva: math & CS
  { class_session: cs_mth201_f26, student: eva, grade: "A"  },
  { class_session: cs_cs101_f26,  student: eva, grade: "A"  },
  { class_session: cs_cs201_f26,  student: eva, grade: "A-" },
  { class_session: cs_mth210_s27, student: eva, grade: nil  },
  { class_session: cs_cs301_s27,  student: eva, grade: nil  },

  # Frank: struggling a bit
  { class_session: cs_eng101_f26, student: frank, grade: "C"  },
  { class_session: cs_mth210_f26, student: frank, grade: "D+" },
  { class_session: cs_his101_f26, student: frank, grade: "C+" },
  { class_session: cs_eng201_s27, student: frank, grade: nil  },

  # Grace: English & history
  { class_session: cs_eng101_f26, student: grace, grade: "A"  },
  { class_session: cs_eng102_f26, student: grace, grade: "A-" },
  { class_session: cs_his101_f26, student: grace, grade: "A"  },
  { class_session: cs_eng201_s27, student: grace, grade: nil  },
  { class_session: cs_his201_s27, student: grace, grade: nil  },

  # Henry: science & math
  { class_session: cs_sci101_f26, student: henry, grade: "B+" },
  { class_session: cs_sci102_f26, student: henry, grade: "B"  },
  { class_session: cs_mth201_f26, student: henry, grade: "B-" },
  { class_session: cs_sci201_s27, student: henry, grade: nil  },

  # Iris: CS & English
  { class_session: cs_cs101_f26,  student: iris, grade: "B"  },
  { class_session: cs_eng102_f26, student: iris, grade: "A-" },
  { class_session: cs_cs201_f26,  student: iris, grade: "B+" },
  { class_session: cs_cs301_s27,  student: iris, grade: nil  },
  { class_session: cs_eng201_s27, student: iris, grade: nil  },

  # James: history & science
  { class_session: cs_his101_f26, student: james, grade: "B+" },
  { class_session: cs_sci101_f26, student: james, grade: "A-" },
  { class_session: cs_mth210_f26, student: james, grade: "B"  },
  { class_session: cs_his201_s27, student: james, grade: nil  },
  { class_session: cs_sci201_s27, student: james, grade: nil  },

  # Karen: all-rounder
  { class_session: cs_eng101_f26, student: karen, grade: "B+" },
  { class_session: cs_mth201_f26, student: karen, grade: "A-" },
  { class_session: cs_sci102_f26, student: karen, grade: "B"  },
  { class_session: cs_cs101_f26,  student: karen, grade: "A"  },
  { class_session: cs_mth101_s27, student: karen, grade: nil  },
  { class_session: cs_cs301_s27,  student: karen, grade: nil  },

  # Leo: math focus
  { class_session: cs_mth201_f26, student: leo, grade: "A"  },
  { class_session: cs_mth210_f26, student: leo, grade: "A"  },
  { class_session: cs_sci101_f26, student: leo, grade: "B+"  },
  { class_session: cs_mth101_s27, student: leo, grade: nil  },
  { class_session: cs_mth210_s27, student: leo, grade: nil  }
]

Enrollment.create!(enrollments)

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
puts "Sample student IDs for testing:"
User.students.order(:id).limit(3).each do |s|
  puts "  #{s.full_name} — GET /api/v1/students/#{s.id}"
  puts "                    GET /api/v1/students/#{s.id}/courses"
end
