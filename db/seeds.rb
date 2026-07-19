# db/seeds.rb
# Run with: rails db:seed
# Creates departments, courses, semesters, teachers, students, class sessions, and enrollments.

puts "Seeding database..."

# ── Departments ──────────────────────────────────────────────────────────────
departments = {}
[
  "English",
  "Mathematics",
  "Science",
  "History",
  "Computer Science"
].each do |name|
  departments[name] = Department.find_or_create_by!(name: name)
end
puts "  #{Department.count} departments"

# ── Courses ───────────────────────────────────────────────────────────────────
course_data = [
  { name: "Introduction to Literature",   code: "ENG101", department: "English",
    description: "Survey of major works of world literature." },
  { name: "Advanced Composition",         code: "ENG201", department: "English",
    description: "Techniques for clear and persuasive writing." },
  { name: "Calculus I",                   code: "MAT101", department: "Mathematics",
    description: "Limits, derivatives, and integrals." },
  { name: "Statistics",                   code: "MAT201", department: "Mathematics",
    description: "Probability, distributions, and hypothesis testing." },
  { name: "Biology",                      code: "SCI101", department: "Science",
    description: "Fundamentals of living organisms." },
  { name: "Chemistry",                    code: "SCI102", department: "Science",
    description: "Atomic structure, bonding, and reactions." },
  { name: "World History",                code: "HIS101", department: "History",
    description: "Survey of human civilization from antiquity to 1900." },
  { name: "US History",                   code: "HIS201", department: "History",
    description: "American history from colonization to the present." },
  { name: "Introduction to Programming",  code: "CS101",  department: "Computer Science",
    description: "Fundamentals of programming using Python." },
  { name: "Data Structures",              code: "CS201",  department: "Computer Science",
    description: "Arrays, linked lists, trees, graphs, and algorithms." }
]

courses = {}
course_data.each do |cd|
  courses[cd[:code]] = Course.find_or_create_by!(code: cd[:code]) do |c|
    c.name        = cd[:name]
    c.description = cd[:description]
    c.department  = departments[cd[:department]]
  end
end
puts "  #{Course.count} courses"

# ── Semesters ─────────────────────────────────────────────────────────────────
semesters = {}
[
  { name: "Fall 2026",   start_date: "2026-09-01", end_date: "2026-12-20" },
  { name: "Spring 2027", start_date: "2027-01-15", end_date: "2027-05-10" }
].each do |sd|
  semesters[sd[:name]] = Semester.find_or_create_by!(name: sd[:name]) do |s|
    s.start_date = sd[:start_date]
    s.end_date   = sd[:end_date]
  end
end
puts "  #{Semester.count} semesters"

# ── Teachers ──────────────────────────────────────────────────────────────────
teacher_data = [
  { first_name: "Alice",   last_name: "Nguyen",    email: "alice.nguyen@school.edu" },
  { first_name: "Bob",     last_name: "Martinez",  email: "bob.martinez@school.edu" },
  { first_name: "Carol",   last_name: "Thompson",  email: "carol.thompson@school.edu" },
  { first_name: "David",   last_name: "Kim",       email: "david.kim@school.edu" },
  { first_name: "Eleanor", last_name: "Okafor",    email: "eleanor.okafor@school.edu" }
]

teachers = teacher_data.map do |td|
  User.find_or_create_by!(email: td[:email]) do |u|
    u.first_name = td[:first_name]
    u.last_name  = td[:last_name]
    u.role       = "teacher"
  end
end
puts "  #{User.teachers.count} teachers"

# ── Students ──────────────────────────────────────────────────────────────────
student_data = [
  { first_name: "Liam",    last_name: "Chen",      email: "liam.chen@students.school.edu" },
  { first_name: "Mia",     last_name: "Patel",     email: "mia.patel@students.school.edu" },
  { first_name: "Noah",    last_name: "Williams",  email: "noah.williams@students.school.edu" },
  { first_name: "Olivia",  last_name: "Johnson",   email: "olivia.johnson@students.school.edu" },
  { first_name: "Ethan",   last_name: "Brown",     email: "ethan.brown@students.school.edu" },
  { first_name: "Sophia",  last_name: "Davis",     email: "sophia.davis@students.school.edu" },
  { first_name: "James",   last_name: "Wilson",    email: "james.wilson@students.school.edu" },
  { first_name: "Ava",     last_name: "Moore",     email: "ava.moore@students.school.edu" },
  { first_name: "Lucas",   last_name: "Taylor",    email: "lucas.taylor@students.school.edu" },
  { first_name: "Isabella",last_name: "Anderson",  email: "isabella.anderson@students.school.edu" }
]

students = student_data.map do |sd|
  User.find_or_create_by!(email: sd[:email]) do |u|
    u.first_name = sd[:first_name]
    u.last_name  = sd[:last_name]
    u.role       = "student"
  end
end
puts "  #{User.students.count} students"

# ── Class Sessions ────────────────────────────────────────────────────────────
# Each course gets one session per semester, rotating through teachers.
rooms     = ["101A", "202B", "303C", "Library Hall", "Science Lab 1"]
schedules = ["MWF 08:00-08:50", "MWF 10:00-10:50", "TTh 09:30-10:45",
             "TTh 13:00-14:15", "MWF 14:00-14:50"]

class_sessions = []
course_list    = courses.values
teacher_cycle  = teachers.cycle

semesters.values.each do |semester|
  course_list.each_with_index do |course, idx|
    teacher  = teacher_cycle.next
    room     = rooms[idx % rooms.length]
    schedule = schedules[idx % schedules.length]

    cs = ClassSession.find_or_create_by!(course: course, semester: semester) do |s|
      s.teacher  = teacher
      s.room     = room
      s.schedule = schedule
    end
    class_sessions << cs
  end
end
puts "  #{ClassSession.count} class sessions"

# ── Enrollments ───────────────────────────────────────────────────────────────
# Each student is enrolled in 4-6 random class sessions per semester,
# with grades assigned for Fall 2026 and nil (in-progress) for Spring 2027.
grades = Enrollment::VALID_GRADES

srand(42) # reproducible randomness

semesters.values.each do |semester|
  sessions_this_sem = class_sessions.select { |cs| cs.semester_id == semester.id }
  graded            = semester.name == "Fall 2026"

  students.each do |student|
    count    = rand(4..6)
    selected = sessions_this_sem.sample(count)

    selected.each do |cs|
      Enrollment.find_or_create_by!(class_session: cs, student: student) do |e|
        e.grade = graded ? grades.sample : nil
      end
    end
  end
end
puts "  #{Enrollment.count} enrollments"

puts "Done! 🎓"
