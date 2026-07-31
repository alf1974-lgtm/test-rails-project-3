# db/seeds.rb
# Run with: rails db:seed

puts "Seeding database..."

# ── Departments ──────────────────────────────────────────────────────────────
departments = {
  english:  Department.find_or_create_by!(name: "English"),
  math:     Department.find_or_create_by!(name: "Mathematics"),
  science:  Department.find_or_create_by!(name: "Science"),
  history:  Department.find_or_create_by!(name: "History"),
  cs:       Department.find_or_create_by!(name: "Computer Science")
}
puts "  #{Department.count} departments"

# ── Courses ───────────────────────────────────────────────────────────────────
courses = {
  eng101: Course.find_or_create_by!(code: "ENG101") { |c|
    c.name = "Composition I"; c.description = "Introduction to academic writing"; c.department = departments[:english]
  },
  eng201: Course.find_or_create_by!(code: "ENG201") { |c|
    c.name = "American Literature"; c.description = "Survey of American literature"; c.department = departments[:english]
  },
  mat101: Course.find_or_create_by!(code: "MAT101") { |c|
    c.name = "Algebra I"; c.description = "Fundamentals of algebra"; c.department = departments[:math]
  },
  mat201: Course.find_or_create_by!(code: "MAT201") { |c|
    c.name = "Calculus I"; c.description = "Limits, derivatives, and integrals"; c.department = departments[:math]
  },
  sci101: Course.find_or_create_by!(code: "SCI101") { |c|
    c.name = "Biology I"; c.description = "Introduction to cell biology and genetics"; c.department = departments[:science]
  },
  sci201: Course.find_or_create_by!(code: "SCI201") { |c|
    c.name = "Chemistry I"; c.description = "Atomic structure and chemical reactions"; c.department = departments[:science]
  },
  his101: Course.find_or_create_by!(code: "HIS101") { |c|
    c.name = "World History"; c.description = "Survey of world history from antiquity"; c.department = departments[:history]
  },
  his201: Course.find_or_create_by!(code: "HIS201") { |c|
    c.name = "US History"; c.description = "United States history from founding to present"; c.department = departments[:history]
  },
  cs101: Course.find_or_create_by!(code: "CS101") { |c|
    c.name = "Intro to Programming"; c.description = "Programming fundamentals using Python"; c.department = departments[:cs]
  },
  cs201: Course.find_or_create_by!(code: "CS201") { |c|
    c.name = "Data Structures"; c.description = "Arrays, linked lists, trees, and graphs"; c.department = departments[:cs]
  }
}
puts "  #{Course.count} courses"

# ── Semesters ─────────────────────────────────────────────────────────────────
semesters = {
  fall2026:   Semester.find_or_create_by!(name: "Fall 2026") { |s|
    s.start_date = "2026-09-01"; s.end_date = "2026-12-20"
  },
  spring2027: Semester.find_or_create_by!(name: "Spring 2027") { |s|
    s.start_date = "2027-01-15"; s.end_date = "2027-05-10"
  }
}
puts "  #{Semester.count} semesters"

# ── Teachers ──────────────────────────────────────────────────────────────────
teachers = [
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",      email: "h.zinn@school.edu",      role: "teacher" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu",     role: "teacher" }
].map { |attrs| User.find_or_create_by!(email: attrs[:email]) { |u| u.assign_attributes(attrs) } }

teacher = teachers.each_with_object({}) do |t, h|
  h[t.last_name.downcase.to_sym] = t
end
puts "  #{User.teachers.count} teachers"

# ── Students ──────────────────────────────────────────────────────────────────
student_data = [
  { first_name: "Alice",   last_name: "Johnson",  email: "alice.johnson@school.edu"  },
  { first_name: "Bob",     last_name: "Smith",    email: "bob.smith@school.edu"      },
  { first_name: "Carol",   last_name: "Williams", email: "carol.williams@school.edu" },
  { first_name: "David",   last_name: "Brown",    email: "david.brown@school.edu"    },
  { first_name: "Eva",     last_name: "Davis",    email: "eva.davis@school.edu"      },
  { first_name: "Frank",   last_name: "Miller",   email: "frank.miller@school.edu"   },
  { first_name: "Grace",   last_name: "Wilson",   email: "grace.wilson@school.edu"   },
  { first_name: "Henry",   last_name: "Moore",    email: "henry.moore@school.edu"    },
  { first_name: "Iris",    last_name: "Taylor",   email: "iris.taylor@school.edu"    },
  { first_name: "James",   last_name: "Anderson", email: "james.anderson@school.edu" }
]

students = student_data.map { |attrs|
  User.find_or_create_by!(email: attrs[:email]) { |u| u.assign_attributes(attrs.merge(role: "student")) }
}
puts "  #{User.students.count} students"

# ── Class Sessions ────────────────────────────────────────────────────────────
sessions_data = [
  # Fall 2026
  { course: courses[:eng101], semester: semesters[:fall2026],   teacher: teacher[:atwood],   room: "A101", schedule: "MWF 09:00-10:00" },
  { course: courses[:mat101], semester: semesters[:fall2026],   teacher: teacher[:feynman],  room: "B202", schedule: "TTh 10:00-11:30" },
  { course: courses[:sci101], semester: semesters[:fall2026],   teacher: teacher[:sagan],    room: "C303", schedule: "MWF 11:00-12:00" },
  { course: courses[:his101], semester: semesters[:fall2026],   teacher: teacher[:zinn],     room: "D404", schedule: "TTh 13:00-14:30" },
  { course: courses[:cs101],  semester: semesters[:fall2026],   teacher: teacher[:lovelace], room: "E505", schedule: "MWF 14:00-15:00" },
  # Spring 2027
  { course: courses[:eng201], semester: semesters[:spring2027], teacher: teacher[:atwood],   room: "A101", schedule: "MWF 09:00-10:00" },
  { course: courses[:mat201], semester: semesters[:spring2027], teacher: teacher[:feynman],  room: "B202", schedule: "TTh 10:00-11:30" },
  { course: courses[:sci201], semester: semesters[:spring2027], teacher: teacher[:sagan],    room: "C303", schedule: "MWF 11:00-12:00" },
  { course: courses[:his201], semester: semesters[:spring2027], teacher: teacher[:zinn],     room: "D404", schedule: "TTh 13:00-14:30" },
  { course: courses[:cs201],  semester: semesters[:spring2027], teacher: teacher[:lovelace], room: "E505", schedule: "MWF 14:00-15:00" }
]

class_sessions = sessions_data.map { |attrs|
  ClassSession.find_or_create_by!(
    course: attrs[:course],
    semester: attrs[:semester],
    teacher: attrs[:teacher]
  ) { |cs| cs.room = attrs[:room]; cs.schedule = attrs[:schedule] }
}
puts "  #{ClassSession.count} class sessions"

# ── Enrollments ───────────────────────────────────────────────────────────────
grades = %w[A A- B+ B B- C+ C]

# Enroll each student in 4 random class sessions with grades
students.each do |student|
  sampled_sessions = class_sessions.sample(4)
  sampled_sessions.each do |cs|
    Enrollment.find_or_create_by!(class_session: cs, student: student) { |e|
      e.grade = grades.sample
    }
  end
end

# Make sure Alice (first student) has a predictable set for easy testing
alice = students.first
class_sessions.first(5).each_with_index do |cs, i|
  Enrollment.find_or_create_by!(class_session: cs, student: alice) { |e|
    e.grade = grades[i % grades.length]
  }
end

puts "  #{Enrollment.count} enrollments"
puts ""
puts "Done! Sample student for testing:"
puts "  Alice Johnson  — id: #{students.first.id}  (#{students.first.email})"
puts ""
puts "Try:"
puts "  GET /students/#{students.first.id}"
puts "  GET /students/#{students.first.id}/courses"
