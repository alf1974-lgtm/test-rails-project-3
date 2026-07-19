# db/seeds.rb
# Run with: bin/rails db:seed
# Clears and repopulates all data.

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Semester.destroy_all
Course.destroy_all
Department.destroy_all
User.destroy_all

# ─── Departments ────────────────────────────────────────────────────────────

puts "Creating departments..."

english    = Department.create!(name: "English")
math       = Department.create!(name: "Mathematics")
science    = Department.create!(name: "Science")
history    = Department.create!(name: "History")
cs         = Department.create!(name: "Computer Science")

# ─── Courses ────────────────────────────────────────────────────────────────

puts "Creating courses..."

# English
eng101 = Course.create!(name: "Composition I",          code: "ENG101", credits: 3, department: english,
                        description: "Introduction to academic writing and rhetoric.")
eng201 = Course.create!(name: "American Literature",    code: "ENG201", credits: 3, department: english,
                        description: "Survey of American literature from colonial times to the present.")
eng301 = Course.create!(name: "Creative Writing",       code: "ENG301", credits: 3, department: english,
                        description: "Workshop-based course in fiction and poetry.")

# Mathematics
mat101 = Course.create!(name: "Pre-Calculus",           code: "MAT101", credits: 3, department: math,
                        description: "Functions, trigonometry, and analytic geometry.")
mat201 = Course.create!(name: "Calculus I",             code: "MAT201", credits: 4, department: math,
                        description: "Limits, derivatives, and integrals of single-variable functions.")
mat301 = Course.create!(name: "Linear Algebra",         code: "MAT301", credits: 3, department: math,
                        description: "Vectors, matrices, and linear transformations.")

# Science
sci101 = Course.create!(name: "Biology I",              code: "SCI101", credits: 4, department: science,
                        description: "Cell biology, genetics, and evolution.")
sci201 = Course.create!(name: "Chemistry I",            code: "SCI201", credits: 4, department: science,
                        description: "Atomic structure, bonding, and chemical reactions.")
sci301 = Course.create!(name: "Physics I",              code: "SCI301", credits: 4, department: science,
                        description: "Mechanics, kinematics, and Newtonian dynamics.")

# History
his101 = Course.create!(name: "World History I",        code: "HIS101", credits: 3, department: history,
                        description: "Ancient civilizations through the Middle Ages.")
his201 = Course.create!(name: "US History",             code: "HIS201", credits: 3, department: history,
                        description: "United States history from colonization to the present.")
his301 = Course.create!(name: "Modern European History",code: "HIS301", credits: 3, department: history,
                        description: "Europe from the Renaissance through the 20th century.")

# Computer Science
cs101  = Course.create!(name: "Intro to Programming",   code: "CS101",  credits: 3, department: cs,
                        description: "Fundamentals of programming using Python.")
cs201  = Course.create!(name: "Data Structures",        code: "CS201",  credits: 3, department: cs,
                        description: "Arrays, linked lists, trees, graphs, and algorithm analysis.")
cs301  = Course.create!(name: "Web Development",        code: "CS301",  credits: 3, department: cs,
                        description: "HTML, CSS, JavaScript, and introductory backend development.")

# ─── Semesters ──────────────────────────────────────────────────────────────

puts "Creating semesters..."

fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-15")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-19", end_date: "2027-05-10")

# ─── Teachers ───────────────────────────────────────────────────────────────

puts "Creating teachers..."

teachers = [
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",      role: "teacher" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu",     role: "teacher" },
  { first_name: "Emmy",     last_name: "Noether",   email: "e.noether@school.edu",   role: "teacher" },
  { first_name: "Grace",    last_name: "Hopper",    email: "g.hopper@school.edu",    role: "teacher" },
  { first_name: "James",    last_name: "Baldwin",   email: "j.baldwin@school.edu",   role: "teacher" },
].map { |attrs| User.create!(attrs) }

t_english, t_physics, t_cs, t_history, t_science, t_math, t_cs2, t_english2 = teachers

# ─── Students ───────────────────────────────────────────────────────────────

puts "Creating students..."

student_data = [
  { first_name: "Alice",   last_name: "Johnson",   email: "alice.johnson@school.edu"   },
  { first_name: "Bob",     last_name: "Smith",     email: "bob.smith@school.edu"       },
  { first_name: "Carol",   last_name: "Williams",  email: "carol.williams@school.edu"  },
  { first_name: "David",   last_name: "Brown",     email: "david.brown@school.edu"     },
  { first_name: "Eva",     last_name: "Davis",     email: "eva.davis@school.edu"       },
  { first_name: "Frank",   last_name: "Miller",    email: "frank.miller@school.edu"    },
  { first_name: "Grace",   last_name: "Wilson",    email: "grace.wilson@school.edu"    },
  { first_name: "Henry",   last_name: "Moore",     email: "henry.moore@school.edu"     },
  { first_name: "Iris",    last_name: "Taylor",    email: "iris.taylor@school.edu"     },
  { first_name: "Jack",    last_name: "Anderson",  email: "jack.anderson@school.edu"   },
  { first_name: "Karen",   last_name: "Thomas",    email: "karen.thomas@school.edu"    },
  { first_name: "Leo",     last_name: "Jackson",   email: "leo.jackson@school.edu"     },
  { first_name: "Mia",     last_name: "White",     email: "mia.white@school.edu"       },
  { first_name: "Noah",    last_name: "Harris",    email: "noah.harris@school.edu"     },
  { first_name: "Olivia",  last_name: "Martin",    email: "olivia.martin@school.edu"   },
  { first_name: "Paul",    last_name: "Garcia",    email: "paul.garcia@school.edu"     },
  { first_name: "Quinn",   last_name: "Martinez",  email: "quinn.martinez@school.edu"  },
  { first_name: "Rachel",  last_name: "Robinson",  email: "rachel.robinson@school.edu" },
  { first_name: "Sam",     last_name: "Clark",     email: "sam.clark@school.edu"       },
  { first_name: "Tina",    last_name: "Rodriguez", email: "tina.rodriguez@school.edu"  },
]

students = student_data.map { |attrs| User.create!(attrs.merge(role: "student")) }

alice, bob, carol, david, eva, frank, grace, henry, iris, jack,
karen, leo, mia, noah, olivia, paul, quinn, rachel, sam, tina = students

# ─── Class Sessions ─────────────────────────────────────────────────────────

puts "Creating class sessions..."

# Fall 2026
cs_eng101_f26   = ClassSession.create!(course: eng101, semester: fall2026,   teacher: t_english,  room: "HUM 101", schedule: "MWF 9:00-9:50")
cs_mat201_f26   = ClassSession.create!(course: mat201, semester: fall2026,   teacher: t_math,     room: "SCI 210", schedule: "MWF 10:00-10:50")
cs_sci101_f26   = ClassSession.create!(course: sci101, semester: fall2026,   teacher: t_science,  room: "SCI 105", schedule: "TTh 9:30-10:45")
cs_his101_f26   = ClassSession.create!(course: his101, semester: fall2026,   teacher: t_history,  room: "HUM 205", schedule: "TTh 11:00-12:15")
cs_cs101_f26    = ClassSession.create!(course: cs101,  semester: fall2026,   teacher: t_cs,       room: "TEC 301", schedule: "MWF 1:00-1:50")
cs_sci201_f26   = ClassSession.create!(course: sci201, semester: fall2026,   teacher: t_physics,  room: "SCI 202", schedule: "MWF 11:00-11:50")
cs_eng201_f26   = ClassSession.create!(course: eng201, semester: fall2026,   teacher: t_english2, room: "HUM 102", schedule: "TTh 2:00-3:15")
cs_mat101_f26   = ClassSession.create!(course: mat101, semester: fall2026,   teacher: t_math,     room: "SCI 211", schedule: "MWF 8:00-8:50")

# Spring 2027
cs_eng301_s27   = ClassSession.create!(course: eng301, semester: spring2027, teacher: t_english,  room: "HUM 103", schedule: "TTh 9:30-10:45")
cs_mat301_s27   = ClassSession.create!(course: mat301, semester: spring2027, teacher: t_math,     room: "SCI 212", schedule: "MWF 10:00-10:50")
cs_sci301_s27   = ClassSession.create!(course: sci301, semester: spring2027, teacher: t_physics,  room: "SCI 301", schedule: "MWF 11:00-11:50")
cs_his201_s27   = ClassSession.create!(course: his201, semester: spring2027, teacher: t_history,  room: "HUM 206", schedule: "TTh 11:00-12:15")
cs_cs201_s27    = ClassSession.create!(course: cs201,  semester: spring2027, teacher: t_cs,       room: "TEC 302", schedule: "MWF 1:00-1:50")
cs_cs301_s27    = ClassSession.create!(course: cs301,  semester: spring2027, teacher: t_cs2,      room: "TEC 303", schedule: "TTh 2:00-3:15")
cs_his301_s27   = ClassSession.create!(course: his301, semester: spring2027, teacher: t_history,  room: "HUM 207", schedule: "MWF 9:00-9:50")
cs_eng201_s27   = ClassSession.create!(course: eng201, semester: spring2027, teacher: t_english2, room: "HUM 104", schedule: "TTh 3:30-4:45")

# ─── Enrollments ────────────────────────────────────────────────────────────

puts "Creating enrollments..."

grades = %w[A A- B+ B B- C+ C C-]

# Helper to enroll a list of students in a class session with random grades
def enroll(class_session, students, grades, graded: true)
  students.each do |student|
    Enrollment.create!(
      class_session: class_session,
      student:       student,
      grade:         graded ? grades.sample : nil
    )
  end
end

# Fall 2026 enrollments (already graded)
enroll(cs_eng101_f26, [alice, bob, carol, david, eva, frank, grace, henry], grades)
enroll(cs_mat201_f26, [alice, carol, eva, henry, iris, jack, karen, leo],   grades)
enroll(cs_sci101_f26, [bob, david, frank, grace, mia, noah, olivia, paul],  grades)
enroll(cs_his101_f26, [alice, bob, quinn, rachel, sam, tina, karen, leo],   grades)
enroll(cs_cs101_f26,  [carol, david, eva, iris, jack, mia, noah, olivia],   grades)
enroll(cs_sci201_f26, [frank, grace, henry, paul, quinn, rachel, sam, tina],grades)
enroll(cs_eng201_f26, [alice, carol, eva, grace, iris, karen, mia, olivia], grades)
enroll(cs_mat101_f26, [bob, david, frank, henry, jack, leo, noah, paul],    grades)

# Spring 2027 enrollments (in progress — no grades yet)
enroll(cs_eng301_s27, [alice, carol, eva, grace, iris, karen, mia, olivia], grades, graded: false)
enroll(cs_mat301_s27, [alice, carol, henry, iris, jack, karen, leo, sam],   grades, graded: false)
enroll(cs_sci301_s27, [bob, david, frank, henry, paul, quinn, rachel, tina],grades, graded: false)
enroll(cs_his201_s27, [alice, bob, quinn, rachel, sam, tina, noah, olivia], grades, graded: false)
enroll(cs_cs201_s27,  [carol, david, eva, iris, jack, mia, noah, olivia],   grades, graded: false)
enroll(cs_cs301_s27,  [alice, carol, eva, frank, grace, henry, iris, jack], grades, graded: false)
enroll(cs_his301_s27, [bob, david, karen, leo, mia, paul, quinn, rachel],   grades, graded: false)
enroll(cs_eng201_s27, [bob, frank, henry, jack, leo, noah, paul, sam],      grades, graded: false)

puts ""
puts "✅ Seed complete!"
puts "   #{User.teachers.count} teachers"
puts "   #{User.students.count} students"
puts "   #{Department.count} departments"
puts "   #{Course.count} courses"
puts "   #{Semester.count} semesters"
puts "   #{ClassSession.count} class sessions"
puts "   #{Enrollment.count} enrollments"
puts ""
puts "Sample student IDs for testing:"
User.students.first(3).each do |s|
  puts "   #{s.id}: #{s.full_name} (#{s.email})"
end
