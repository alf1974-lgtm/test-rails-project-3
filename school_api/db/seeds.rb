# =============================================================================
# School API — Seed Data
# =============================================================================
puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Semester.destroy_all
Course.destroy_all
Department.destroy_all
User.destroy_all

# =============================================================================
# Departments
# =============================================================================
puts "Creating departments..."
english    = Department.create!(name: "English")
math       = Department.create!(name: "Mathematics")
science    = Department.create!(name: "Science")
history    = Department.create!(name: "History")
cs         = Department.create!(name: "Computer Science")

# =============================================================================
# Courses
# =============================================================================
puts "Creating courses..."
# English
eng101 = Course.create!(name: "Composition I",          code: "ENG101", credits: 3, department: english,
                        description: "Introduction to academic writing and rhetoric.")
eng201 = Course.create!(name: "American Literature",    code: "ENG201", credits: 3, department: english,
                        description: "Survey of American literature from colonial times to the present.")

# Math
mat101 = Course.create!(name: "College Algebra",        code: "MAT101", credits: 3, department: math,
                        description: "Fundamentals of algebra including functions and graphs.")
mat201 = Course.create!(name: "Calculus I",             code: "MAT201", credits: 4, department: math,
                        description: "Limits, derivatives, and integrals of single-variable functions.")

# Science
sci101 = Course.create!(name: "Biology I",              code: "SCI101", credits: 4, department: science,
                        description: "Introduction to cell biology, genetics, and evolution.")
sci201 = Course.create!(name: "Chemistry I",            code: "SCI201", credits: 4, department: science,
                        description: "Atomic structure, bonding, and chemical reactions.")

# History
his101 = Course.create!(name: "World History I",        code: "HIS101", credits: 3, department: history,
                        description: "Ancient civilizations through the early modern period.")
his201 = Course.create!(name: "U.S. History",           code: "HIS201", credits: 3, department: history,
                        description: "American history from colonization through the 20th century.")

# Computer Science
csc101 = Course.create!(name: "Intro to Programming",   code: "CSC101", credits: 3, department: cs,
                        description: "Fundamentals of programming using Python.")
csc201 = Course.create!(name: "Data Structures",        code: "CSC201", credits: 3, department: cs,
                        description: "Arrays, linked lists, trees, graphs, and algorithm analysis.")

# =============================================================================
# Semesters
# =============================================================================
puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-15")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-19", end_date: "2027-05-10")

# =============================================================================
# Teachers
# =============================================================================
puts "Creating teachers..."
t1 = User.create!(first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher")
t2 = User.create!(first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher")
t3 = User.create!(first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher")
t4 = User.create!(first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",      role: "teacher")
t5 = User.create!(first_name: "Grace",    last_name: "Hopper",    email: "g.hopper@school.edu",    role: "teacher")

# =============================================================================
# Students
# =============================================================================
puts "Creating students..."
s1  = User.create!(first_name: "Alice",   last_name: "Johnson",   email: "alice.johnson@school.edu",   role: "student")
s2  = User.create!(first_name: "Bob",     last_name: "Smith",     email: "bob.smith@school.edu",       role: "student")
s3  = User.create!(first_name: "Carol",   last_name: "Williams",  email: "carol.williams@school.edu",  role: "student")
s4  = User.create!(first_name: "David",   last_name: "Brown",     email: "david.brown@school.edu",     role: "student")
s5  = User.create!(first_name: "Eva",     last_name: "Davis",     email: "eva.davis@school.edu",       role: "student")
s6  = User.create!(first_name: "Frank",   last_name: "Miller",    email: "frank.miller@school.edu",    role: "student")
s7  = User.create!(first_name: "Grace",   last_name: "Wilson",    email: "grace.wilson@school.edu",    role: "student")
s8  = User.create!(first_name: "Henry",   last_name: "Moore",     email: "henry.moore@school.edu",     role: "student")
s9  = User.create!(first_name: "Iris",    last_name: "Taylor",    email: "iris.taylor@school.edu",     role: "student")
s10 = User.create!(first_name: "Jack",    last_name: "Anderson",  email: "jack.anderson@school.edu",   role: "student")

# =============================================================================
# Class Sessions — Fall 2026
# =============================================================================
puts "Creating class sessions for Fall 2026..."
cs_eng101_f26  = ClassSession.create!(course: eng101, semester: fall2026,   teacher: t1, room: "Humanities 101", schedule: "MWF 9:00-9:50am")
cs_mat101_f26  = ClassSession.create!(course: mat101, semester: fall2026,   teacher: t2, room: "Science 204",    schedule: "TTh 10:00-11:15am")
cs_sci101_f26  = ClassSession.create!(course: sci101, semester: fall2026,   teacher: t2, room: "Science 110",    schedule: "MWF 11:00-11:50am")
cs_his101_f26  = ClassSession.create!(course: his101, semester: fall2026,   teacher: t4, room: "Social Sci 305", schedule: "TTh 1:00-2:15pm")
cs_csc101_f26  = ClassSession.create!(course: csc101, semester: fall2026,   teacher: t5, room: "Tech 201",       schedule: "MWF 2:00-2:50pm")

# =============================================================================
# Class Sessions — Spring 2027
# =============================================================================
puts "Creating class sessions for Spring 2027..."
cs_eng201_s27  = ClassSession.create!(course: eng201, semester: spring2027, teacher: t1, room: "Humanities 102", schedule: "MWF 9:00-9:50am")
cs_mat201_s27  = ClassSession.create!(course: mat201, semester: spring2027, teacher: t2, room: "Science 205",    schedule: "TTh 10:00-11:15am")
cs_sci201_s27  = ClassSession.create!(course: sci201, semester: spring2027, teacher: t3, room: "Science 111",    schedule: "MWF 11:00-11:50am")
cs_his201_s27  = ClassSession.create!(course: his201, semester: spring2027, teacher: t4, room: "Social Sci 306", schedule: "TTh 1:00-2:15pm")
cs_csc201_s27  = ClassSession.create!(course: csc201, semester: spring2027, teacher: t5, room: "Tech 202",       schedule: "MWF 2:00-2:50pm")

# =============================================================================
# Enrollments (students in Fall 2026 sessions — with grades)
# =============================================================================
puts "Creating enrollments for Fall 2026..."

# ENG101 — Fall 2026
Enrollment.create!(class_session: cs_eng101_f26, student: s1,  grade: "A")
Enrollment.create!(class_session: cs_eng101_f26, student: s2,  grade: "B+")
Enrollment.create!(class_session: cs_eng101_f26, student: s3,  grade: "A-")
Enrollment.create!(class_session: cs_eng101_f26, student: s4,  grade: "C+")
Enrollment.create!(class_session: cs_eng101_f26, student: s5,  grade: "B")

# MAT101 — Fall 2026
Enrollment.create!(class_session: cs_mat101_f26, student: s1,  grade: "B")
Enrollment.create!(class_session: cs_mat101_f26, student: s3,  grade: "A")
Enrollment.create!(class_session: cs_mat101_f26, student: s6,  grade: "C")
Enrollment.create!(class_session: cs_mat101_f26, student: s7,  grade: "B+")
Enrollment.create!(class_session: cs_mat101_f26, student: s8,  grade: "A-")

# SCI101 — Fall 2026
Enrollment.create!(class_session: cs_sci101_f26, student: s2,  grade: "A-")
Enrollment.create!(class_session: cs_sci101_f26, student: s4,  grade: "B")
Enrollment.create!(class_session: cs_sci101_f26, student: s5,  grade: "B+")
Enrollment.create!(class_session: cs_sci101_f26, student: s9,  grade: "C+")
Enrollment.create!(class_session: cs_sci101_f26, student: s10, grade: "A")

# HIS101 — Fall 2026
Enrollment.create!(class_session: cs_his101_f26, student: s1,  grade: "A")
Enrollment.create!(class_session: cs_his101_f26, student: s6,  grade: "B-")
Enrollment.create!(class_session: cs_his101_f26, student: s7,  grade: "A-")
Enrollment.create!(class_session: cs_his101_f26, student: s8,  grade: "B")
Enrollment.create!(class_session: cs_his101_f26, student: s9,  grade: "C")

# CSC101 — Fall 2026
Enrollment.create!(class_session: cs_csc101_f26, student: s2,  grade: "A")
Enrollment.create!(class_session: cs_csc101_f26, student: s3,  grade: "B+")
Enrollment.create!(class_session: cs_csc101_f26, student: s5,  grade: "A-")
Enrollment.create!(class_session: cs_csc101_f26, student: s10, grade: "B")
Enrollment.create!(class_session: cs_csc101_f26, student: s4,  grade: "C+")

# =============================================================================
# Enrollments (students in Spring 2027 sessions — grades pending/partial)
# =============================================================================
puts "Creating enrollments for Spring 2027..."

# ENG201 — Spring 2027
Enrollment.create!(class_session: cs_eng201_s27, student: s1,  grade: nil)
Enrollment.create!(class_session: cs_eng201_s27, student: s2,  grade: nil)
Enrollment.create!(class_session: cs_eng201_s27, student: s6,  grade: nil)
Enrollment.create!(class_session: cs_eng201_s27, student: s7,  grade: nil)

# MAT201 — Spring 2027
Enrollment.create!(class_session: cs_mat201_s27, student: s1,  grade: nil)
Enrollment.create!(class_session: cs_mat201_s27, student: s3,  grade: nil)
Enrollment.create!(class_session: cs_mat201_s27, student: s8,  grade: nil)
Enrollment.create!(class_session: cs_mat201_s27, student: s9,  grade: nil)

# SCI201 — Spring 2027
Enrollment.create!(class_session: cs_sci201_s27, student: s4,  grade: nil)
Enrollment.create!(class_session: cs_sci201_s27, student: s5,  grade: nil)
Enrollment.create!(class_session: cs_sci201_s27, student: s10, grade: nil)

# HIS201 — Spring 2027
Enrollment.create!(class_session: cs_his201_s27, student: s2,  grade: nil)
Enrollment.create!(class_session: cs_his201_s27, student: s6,  grade: nil)
Enrollment.create!(class_session: cs_his201_s27, student: s7,  grade: nil)
Enrollment.create!(class_session: cs_his201_s27, student: s8,  grade: nil)

# CSC201 — Spring 2027
Enrollment.create!(class_session: cs_csc201_s27, student: s3,  grade: nil)
Enrollment.create!(class_session: cs_csc201_s27, student: s5,  grade: nil)
Enrollment.create!(class_session: cs_csc201_s27, student: s9,  grade: nil)
Enrollment.create!(class_session: cs_csc201_s27, student: s10, grade: nil)

# =============================================================================
puts ""
puts "Seed complete!"
puts "  Departments:    #{Department.count}"
puts "  Courses:        #{Course.count}"
puts "  Semesters:      #{Semester.count}"
puts "  Teachers:       #{User.teachers.count}"
puts "  Students:       #{User.students.count}"
puts "  Class Sessions: #{ClassSession.count}"
puts "  Enrollments:    #{Enrollment.count}"
puts ""
puts "Sample student IDs: #{User.students.order(:id).limit(3).pluck(:id, :first_name).map { |id, n| "#{id} (#{n})" }.join(', ')}"
