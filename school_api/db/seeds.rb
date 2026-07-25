puts "Seeding database..."

# ─── Departments ────────────────────────────────────────────────────────────
departments = {
  english:  Department.find_or_create_by!(name: "English")    { |d| d.description = "Literature, writing, and language arts" },
  math:     Department.find_or_create_by!(name: "Mathematics") { |d| d.description = "Algebra, calculus, statistics, and more" },
  science:  Department.find_or_create_by!(name: "Science")    { |d| d.description = "Biology, chemistry, physics, and earth science" },
  history:  Department.find_or_create_by!(name: "History")    { |d| d.description = "World and American history" },
  cs:       Department.find_or_create_by!(name: "Computer Science") { |d| d.description = "Programming, algorithms, and systems" }
}
puts "  Created #{Department.count} departments"

# ─── Courses ────────────────────────────────────────────────────────────────
courses_data = [
  # English
  { code: "ENG101", name: "Composition I",            credits: 3, department: departments[:english],  description: "Introduction to academic writing" },
  { code: "ENG201", name: "American Literature",      credits: 3, department: departments[:english],  description: "Survey of American literary works" },
  { code: "ENG301", name: "Creative Writing",         credits: 3, department: departments[:english],  description: "Fiction, poetry, and creative nonfiction" },
  # Math
  { code: "MAT101", name: "Pre-Calculus",             credits: 4, department: departments[:math],     description: "Functions, trigonometry, and analytic geometry" },
  { code: "MAT201", name: "Calculus I",               credits: 4, department: departments[:math],     description: "Limits, derivatives, and integrals" },
  { code: "MAT301", name: "Statistics",               credits: 3, department: departments[:math],     description: "Probability and statistical inference" },
  # Science
  { code: "SCI101", name: "Biology I",                credits: 4, department: departments[:science],  description: "Cell biology, genetics, and evolution" },
  { code: "SCI201", name: "Chemistry I",              credits: 4, department: departments[:science],  description: "Atomic structure, bonding, and reactions" },
  { code: "SCI301", name: "Physics I",                credits: 4, department: departments[:science],  description: "Mechanics, thermodynamics, and waves" },
  # History
  { code: "HIS101", name: "World History I",          credits: 3, department: departments[:history],  description: "Ancient civilizations through the Renaissance" },
  { code: "HIS201", name: "American History",         credits: 3, department: departments[:history],  description: "Colonial era through the 20th century" },
  # Computer Science
  { code: "CS101",  name: "Intro to Programming",     credits: 3, department: departments[:cs],       description: "Programming fundamentals using Python" },
  { code: "CS201",  name: "Data Structures",          credits: 3, department: departments[:cs],       description: "Arrays, linked lists, trees, and graphs" },
  { code: "CS301",  name: "Web Development",          credits: 3, department: departments[:cs],       description: "HTML, CSS, JavaScript, and Rails" }
]

courses = {}
courses_data.each do |attrs|
  dept = attrs.delete(:department)
  course = Course.find_or_create_by!(code: attrs[:code]) do |c|
    c.assign_attributes(attrs.merge(department: dept))
  end
  courses[attrs[:code].to_sym] = course
end
puts "  Created #{Course.count} courses"

# ─── Semesters ──────────────────────────────────────────────────────────────
fall2026 = Semester.find_or_create_by!(name: "Fall 2026") do |s|
  s.start_date = Date.new(2026, 8, 24)
  s.end_date   = Date.new(2026, 12, 18)
end

spring2027 = Semester.find_or_create_by!(name: "Spring 2027") do |s|
  s.start_date = Date.new(2027, 1, 11)
  s.end_date   = Date.new(2027, 5, 7)
end
puts "  Created #{Semester.count} semesters"

# ─── Teachers ───────────────────────────────────────────────────────────────
teachers_data = [
  { first_name: "Margaret", last_name: "Atwood",    email: "m.atwood@school.edu",    role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",   email: "r.feynman@school.edu",   role: "teacher" },
  { first_name: "Ada",      last_name: "Lovelace",  email: "a.lovelace@school.edu",  role: "teacher" },
  { first_name: "Carl",     last_name: "Sagan",     email: "c.sagan@school.edu",     role: "teacher" },
  { first_name: "Euclid",   last_name: "of Alexandria", email: "euclid@school.edu",  role: "teacher" }
]

teachers = teachers_data.map do |attrs|
  User.find_or_create_by!(email: attrs[:email]) { |u| u.assign_attributes(attrs) }
end
puts "  Created #{User.teachers.count} teachers"

# ─── Students ───────────────────────────────────────────────────────────────
students_data = [
  { first_name: "Alice",   last_name: "Johnson",  email: "alice.johnson@students.edu",  role: "student" },
  { first_name: "Bob",     last_name: "Smith",    email: "bob.smith@students.edu",      role: "student" },
  { first_name: "Carol",   last_name: "Williams", email: "carol.williams@students.edu", role: "student" },
  { first_name: "David",   last_name: "Brown",    email: "david.brown@students.edu",    role: "student" },
  { first_name: "Eva",     last_name: "Davis",    email: "eva.davis@students.edu",      role: "student" },
  { first_name: "Frank",   last_name: "Miller",   email: "frank.miller@students.edu",   role: "student" },
  { first_name: "Grace",   last_name: "Wilson",   email: "grace.wilson@students.edu",   role: "student" },
  { first_name: "Henry",   last_name: "Moore",    email: "henry.moore@students.edu",    role: "student" },
  { first_name: "Iris",    last_name: "Taylor",   email: "iris.taylor@students.edu",    role: "student" },
  { first_name: "Jack",    last_name: "Anderson", email: "jack.anderson@students.edu",  role: "student" }
]

students = students_data.map do |attrs|
  User.find_or_create_by!(email: attrs[:email]) { |u| u.assign_attributes(attrs) }
end
puts "  Created #{User.students.count} students"

# ─── Class Sessions ─────────────────────────────────────────────────────────
# teacher aliases for readability
t_atwood   = teachers[0]  # English
t_feynman  = teachers[1]  # Science / Math
t_lovelace = teachers[2]  # CS
t_sagan    = teachers[3]  # Science / History
t_euclid   = teachers[4]  # Math

sessions_data = [
  # Fall 2026
  { course: courses[:ENG101], semester: fall2026,   teacher: t_atwood,   room: "Humanities 101", schedule: "MWF 9:00-9:50"   },
  { course: courses[:ENG201], semester: fall2026,   teacher: t_atwood,   room: "Humanities 102", schedule: "TTh 10:00-11:15" },
  { course: courses[:MAT101], semester: fall2026,   teacher: t_euclid,   room: "Math 201",       schedule: "MWF 10:00-10:50" },
  { course: courses[:MAT201], semester: fall2026,   teacher: t_euclid,   room: "Math 202",       schedule: "MWF 11:00-11:50" },
  { course: courses[:SCI101], semester: fall2026,   teacher: t_feynman,  room: "Science 301",    schedule: "TTh 1:00-2:15"   },
  { course: courses[:SCI201], semester: fall2026,   teacher: t_sagan,    room: "Science 302",    schedule: "MWF 2:00-2:50"   },
  { course: courses[:HIS101], semester: fall2026,   teacher: t_sagan,    room: "History 101",    schedule: "TTh 9:00-10:15"  },
  { course: courses[:CS101],  semester: fall2026,   teacher: t_lovelace, room: "CS Lab 1",       schedule: "MWF 3:00-3:50"   },
  # Spring 2027
  { course: courses[:ENG301], semester: spring2027, teacher: t_atwood,   room: "Humanities 103", schedule: "TTh 10:00-11:15" },
  { course: courses[:MAT301], semester: spring2027, teacher: t_euclid,   room: "Math 203",       schedule: "MWF 9:00-9:50"   },
  { course: courses[:SCI301], semester: spring2027, teacher: t_feynman,  room: "Science 303",    schedule: "MWF 11:00-11:50" },
  { course: courses[:HIS201], semester: spring2027, teacher: t_sagan,    room: "History 102",    schedule: "TTh 1:00-2:15"   },
  { course: courses[:CS201],  semester: spring2027, teacher: t_lovelace, room: "CS Lab 2",       schedule: "MWF 2:00-2:50"   },
  { course: courses[:CS301],  semester: spring2027, teacher: t_lovelace, room: "CS Lab 1",       schedule: "TTh 3:00-4:15"   }
]

class_sessions = sessions_data.map do |attrs|
  ClassSession.find_or_create_by!(
    course:   attrs[:course],
    semester: attrs[:semester],
    teacher:  attrs[:teacher]
  ) do |cs|
    cs.room     = attrs[:room]
    cs.schedule = attrs[:schedule]
  end
end
puts "  Created #{ClassSession.count} class sessions"

# ─── Enrollments ────────────────────────────────────────────────────────────
grades = Enrollment::GRADES

# Assign each student to 4-6 class sessions with grades
# Fall 2026 sessions: indices 0-7, Spring 2027: indices 8-13
fall_sessions   = class_sessions[0..7]
spring_sessions = class_sessions[8..13]

students.each_with_index do |student, i|
  # Pick 3 fall sessions and 2-3 spring sessions per student
  chosen_fall   = fall_sessions.rotate(i).first(3)
  chosen_spring = spring_sessions.rotate(i).first(3)

  chosen_fall.each do |cs|
    Enrollment.find_or_create_by!(student: student, class_session: cs) do |e|
      e.grade = grades.sample  # Fall is done — everyone has a grade
    end
  end

  chosen_spring.each do |cs|
    Enrollment.find_or_create_by!(student: student, class_session: cs) do |e|
      # Spring is in progress — some students have grades, some don't
      e.grade = [grades.sample, nil].sample
    end
  end
end

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
puts "Sample student IDs: #{User.students.limit(3).pluck(:id, :first_name).map { |id, name| "#{name} (id=#{id})" }.join(', ')}"
