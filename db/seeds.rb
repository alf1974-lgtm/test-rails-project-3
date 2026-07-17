# db/seeds.rb
# Riverside Preparatory Academy seed data
# Grades 9-12, ~600 students, 45 teachers, 8 departments

Rails.logger.debug 'Seeding Riverside Preparatory Academy...'

# ─── Departments ────────────────────────────────────────────────────────────
department_names = [
  'English', 'Math', 'Science', 'Fine Arts',
  'Foreign Languages', 'Ethics', 'Physical Education', 'History'
]

department_names.index_by do |name|
  Department.find_or_create_by!(name: name)
end
# departments is now { dept_record => name } — flip it for lookup by name
dept = department_names.index_with do |name|
  Department.find_by!(name: name)
end
Rails.logger.debug { "  #{Department.count} departments created." }

# ─── Semesters ──────────────────────────────────────────────────────────────
Semester.find_or_create_by!(name: 'Fall 2026') do |s|
  s.season = 'Fall'
  s.year   = 2026
end

Semester.find_or_create_by!(name: 'Spring 2027') do |s|
  s.season = 'Spring'
  s.year   = 2027
end

fall   = Semester.find_by!(name: 'Fall 2026')
spring = Semester.find_by!(name: 'Spring 2027')
Rails.logger.debug { "  #{Semester.count} semesters created." }

# ─── Courses ────────────────────────────────────────────────────────────────
course_data = [
  # English
  { name: 'English 9: Literature & Composition', code: 'ENG101', dept: 'English' },
  { name: 'English 10: World Literature',        code: 'ENG201', dept: 'English' },
  { name: 'English 11: American Literature',     code: 'ENG301', dept: 'English' },
  { name: 'AP English Language',                 code: 'ENG401', dept: 'English' },
  { name: 'Creative Writing',                    code: 'ENG410', dept: 'English' },
  # Math
  { name: 'Algebra I',                           code: 'MTH101', dept: 'Math' },
  { name: 'Geometry',                            code: 'MTH201', dept: 'Math' },
  { name: 'Algebra II',                          code: 'MTH301', dept: 'Math' },
  { name: 'Pre-Calculus',                        code: 'MTH401', dept: 'Math' },
  { name: 'AP Calculus AB',                      code: 'MTH410', dept: 'Math' },
  { name: 'Statistics',                          code: 'MTH420', dept: 'Math' },
  # Science
  { name: 'Biology',                             code: 'SCI101', dept: 'Science' },
  { name: 'Chemistry',                           code: 'SCI201', dept: 'Science' },
  { name: 'Physics',                             code: 'SCI301', dept: 'Science' },
  { name: 'AP Biology',                          code: 'SCI401', dept: 'Science' },
  { name: 'Environmental Science',               code: 'SCI410', dept: 'Science' },
  # History
  { name: 'World History',                       code: 'HIS101', dept: 'History' },
  { name: 'US History',                          code: 'HIS201', dept: 'History' },
  { name: 'AP US History',                       code: 'HIS301', dept: 'History' },
  { name: 'Government & Politics',               code: 'HIS401', dept: 'History' },
  # Foreign Languages
  { name: 'Spanish I',                           code: 'SPN101', dept: 'Foreign Languages' },
  { name: 'Spanish II',                          code: 'SPN201', dept: 'Foreign Languages' },
  { name: 'French I',                            code: 'FRN101', dept: 'Foreign Languages' },
  { name: 'French II',                           code: 'FRN201', dept: 'Foreign Languages' },
  { name: 'Mandarin I',                          code: 'MND101', dept: 'Foreign Languages' },
  # Fine Arts
  { name: 'Studio Art',                          code: 'ART101', dept: 'Fine Arts' },
  { name: 'Music Theory',                        code: 'ART201', dept: 'Fine Arts' },
  { name: 'Drama',                               code: 'ART301', dept: 'Fine Arts' },
  # Ethics
  { name: 'Introduction to Ethics',              code: 'ETH101', dept: 'Ethics' },
  { name: 'Applied Ethics',                      code: 'ETH201', dept: 'Ethics' },
  # Physical Education
  { name: 'Physical Education 9',                code: 'PE101',  dept: 'Physical Education' },
  { name: 'Physical Education 10',               code: 'PE201',  dept: 'Physical Education' },
  { name: 'Health & Wellness',                   code: 'PE301',  dept: 'Physical Education' }
]

course_data.each do |cd|
  Course.find_or_create_by!(code: cd[:code]) do |c|
    c.name       = cd[:name]
    c.department = dept[cd[:dept]]
  end
end
Rails.logger.debug { "  #{Course.count} courses created." }

# ─── Teachers (45) ──────────────────────────────────────────────────────────
teacher_data = [
  # English (6)
  { first: 'Margaret', last: 'Holloway',   email: 'm.holloway@riverside.edu' },
  { first: 'James',    last: 'Whitfield',  email: 'j.whitfield@riverside.edu' },
  { first: 'Diane',    last: 'Okafor',     email: 'd.okafor@riverside.edu' },
  { first: 'Robert',   last: 'Castillo',   email: 'r.castillo@riverside.edu' },
  { first: 'Priya',    last: 'Nair',       email: 'p.nair@riverside.edu' },
  { first: 'Thomas',   last: 'Brennan',    email: 't.brennan@riverside.edu' },
  # Math (7)
  { first: 'Sandra',   last: 'Kowalski',   email: 's.kowalski@riverside.edu' },
  { first: 'David',    last: 'Osei',       email: 'd.osei@riverside.edu' },
  { first: 'Linda',    last: 'Fujimoto',   email: 'l.fujimoto@riverside.edu' },
  { first: 'Carlos',   last: 'Mendez',     email: 'c.mendez@riverside.edu' },
  { first: 'Rachel',   last: 'Goldstein',  email: 'r.goldstein@riverside.edu' },
  { first: 'Kevin',    last: 'Park',       email: 'k.park@riverside.edu' },
  { first: 'Amara',    last: 'Diallo',     email: 'a.diallo@riverside.edu' },
  # Science (6)
  { first: 'Brian',    last: 'Thornton',   email: 'b.thornton@riverside.edu' },
  { first: 'Yuki',     last: 'Tanaka',     email: 'y.tanaka@riverside.edu' },
  { first: 'Fatima',   last: 'Al-Hassan',  email: 'f.alhassan@riverside.edu' },
  { first: 'Gregory',  last: 'Simmons',    email: 'g.simmons@riverside.edu' },
  { first: 'Natalie',  last: 'Voss',       email: 'n.voss@riverside.edu' },
  { first: 'Marcus',   last: 'Webb',       email: 'm.webb@riverside.edu' },
  # History (5)
  { first: 'Eleanor',  last: 'Fitzgerald', email: 'e.fitzgerald@riverside.edu' },
  { first: 'Jerome',   last: 'Watkins',    email: 'j.watkins@riverside.edu' },
  { first: 'Ingrid',   last: 'Sorensen',   email: 'i.sorensen@riverside.edu' },
  { first: 'Patrick',  last: 'Nguyen',     email: 'p.nguyen@riverside.edu' },
  { first: 'Claudia',  last: 'Reyes',      email: 'c.reyes@riverside.edu' },
  # Foreign Languages (5)
  { first: 'Sofia',    last: 'Delgado',    email: 's.delgado@riverside.edu' },
  { first: 'Henri',    last: 'Beaumont',   email: 'h.beaumont@riverside.edu' },
  { first: 'Mei',      last: 'Chen',       email: 'm.chen@riverside.edu' },
  { first: 'Alejandro', last: 'Vargas',    email: 'a.vargas@riverside.edu' },
  { first: 'Isabelle', last: 'Moreau',     email: 'i.moreau@riverside.edu' },
  # Fine Arts (4)
  { first: 'Victor',   last: 'Adeyemi',    email: 'v.adeyemi@riverside.edu' },
  { first: 'Chloe',    last: 'Hartmann',   email: 'c.hartmann@riverside.edu' },
  { first: 'Samuel',   last: 'Okonkwo',    email: 's.okonkwo@riverside.edu' },
  { first: 'Leila',    last: 'Nazari',     email: 'l.nazari@riverside.edu' },
  # Ethics (3)
  { first: 'Arthur',   last: 'Pemberton',  email: 'a.pemberton@riverside.edu' },
  { first: 'Zoe',      last: 'Blackwood',  email: 'z.blackwood@riverside.edu' },
  { first: 'Kwame',    last: 'Asante',     email: 'k.asante@riverside.edu' },
  # Physical Education (4)
  { first: 'Derek',    last: 'Sullivan',   email: 'd.sullivan@riverside.edu' },
  { first: 'Tanya',    last: 'Brooks',     email: 't.brooks@riverside.edu' },
  { first: 'Hector',   last: 'Romero',     email: 'h.romero@riverside.edu' },
  { first: 'Vanessa',  last: 'Kimura',     email: 'v.kimura@riverside.edu' },
  # Cross-department elective teachers (5)
  { first: 'Owen',     last: 'Fletcher',   email: 'o.fletcher@riverside.edu' },
  { first: 'Nina',     last: 'Petrov',     email: 'n.petrov@riverside.edu' },
  { first: 'Darius',   last: 'Coleman',    email: 'd.coleman@riverside.edu' },
  { first: 'Serena',   last: 'Huang',      email: 's.huang@riverside.edu' },
  { first: 'Malcolm',  last: 'Oduya',      email: 'm.oduya@riverside.edu' }
]

teachers = teacher_data.map do |td|
  User.find_or_create_by!(email: td[:email]) do |u|
    u.first_name = td[:first]
    u.last_name  = td[:last]
    u.role       = 'teacher'
  end
end
Rails.logger.debug { "  #{User.where(role: 'teacher').count} teachers created." }

# ─── Students (60 sample — representative subset) ───────────────────────────
first_names = %w[
  Aiden Emma Liam Olivia Noah Ava William Sophia James Isabella
  Oliver Mia Benjamin Charlotte Elijah Amelia Lucas Harper Mason Evelyn
  Ethan Abigail Alexander Emily Daniel Elizabeth Michael Sofia Jackson Avery
  Sebastian Ella Mateo Scarlett Jack Grace Owen Victoria Henry Chloe
  Samuel Riley David Aria Joseph Penelope Carter Layla Wyatt Lillian
  John Zoey Luke Nora Gabriel Riley Caleb Hannah Isaac Lily
]

last_names = %w[
  Anderson Johnson Williams Brown Jones Garcia Miller Davis Wilson Moore
  Taylor Anderson Thomas Jackson White Harris Martin Thompson Garcia Martinez
  Robinson Clark Rodriguez Lewis Lee Walker Hall Allen Young Hernandez
  King Wright Lopez Hill Scott Green Adams Baker Gonzalez Nelson
  Carter Mitchell Perez Roberts Turner Phillips Campbell Parker Evans Edwards
]

grades_dist = ([9] * 15) + ([10] * 15) + ([11] * 15) + ([12] * 15)

60.times do |i|
  fn    = first_names[i % first_names.length]
  ln    = last_names[i % last_names.length]
  grade = grades_dist[i]
  email = "#{fn.downcase}.#{ln.downcase}#{i + 1}@student.riverside.edu"

  User.find_or_create_by!(email: email) do |u|
    u.first_name = fn
    u.last_name  = ln
    u.role       = 'student'
    u.grade      = grade
    u.advisor    = teachers.sample
  end
end
Rails.logger.debug { "  #{User.where(role: 'student').count} students created." }

# ─── Class Sessions ─────────────────────────────────────────────────────────
# Assign courses to teachers and create sessions for both semesters
courses   = Course.all.to_a
students  = User.where(role: 'student').to_a
semesters = [fall, spring]

# Map courses to teachers (roughly by department)
teacher_list = User.where(role: 'teacher').to_a

session_count = 0
courses.each_with_index do |course, idx|
  teacher = teacher_list[idx % teacher_list.length]

  semesters.each do |semester|
    session = ClassSession.find_or_create_by!(
      course: course, semester: semester, teacher: teacher
    )
    session_count += 1

    # Enroll 12-18 students per session
    enrolled_count = rand(12..18)
    sample_students = students.sample(enrolled_count)

    sample_students.each do |student|
      next if Enrollment.exists?(class_session: session, student: student)

      Enrollment.create!(
        class_session: session,
        student: student,
        grade: User::LETTER_GRADES.sample
      )
    end
  end
end

Rails.logger.debug { "  #{ClassSession.count} class sessions created." }
Rails.logger.debug { "  #{Enrollment.count} enrollments created." }
Rails.logger.debug ''
Rails.logger.debug 'Seeding complete! Riverside Preparatory Academy is ready.'
Rails.logger.debug { "  Departments : #{Department.count}" }
Rails.logger.debug { "  Semesters   : #{Semester.count}" }
Rails.logger.debug { "  Courses     : #{Course.count}" }
Rails.logger.debug { "  Teachers    : #{User.where(role: 'teacher').count}" }
Rails.logger.debug { "  Students    : #{User.where(role: 'student').count}" }
Rails.logger.debug { "  Sessions    : #{ClassSession.count}" }
Rails.logger.debug { "  Enrollments : #{Enrollment.count}" }
