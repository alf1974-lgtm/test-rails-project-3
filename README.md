# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

Built as a learning/demo project.

---

## Setup

```bash
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
```

---

## Data Model

```
User (role: student | teacher)
  ├── has_many :enrollments          (as student)
  ├── has_many :class_sessions       (through enrollments, as student)
  └── has_many :taught_sessions      (as teacher → ClassSession)

Department
  └── has_many :courses

Course
  ├── belongs_to :department
  └── has_many :class_sessions

Semester
  └── has_many :class_sessions

ClassSession
  ├── belongs_to :course
  ├── belongs_to :semester
  ├── belongs_to :teacher  (User with role=teacher)
  ├── has_many :enrollments
  └── has_many :students   (through enrollments)

Enrollment  (join table: ClassSession ↔ Student)
  ├── belongs_to :class_session
  ├── belongs_to :student  (User with role=student)
  └── grade  (string, e.g. "A", "B+", nil if not yet graded)
```

---

## API Routes

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/v1/students/:id` | Student profile |
| `GET` | `/api/v1/students/:id/courses` | Student's enrollments with grades |
| `GET` | `/api/v1/departments` | All departments |
| `GET` | `/api/v1/departments/:id` | Single department with courses |
| `GET` | `/api/v1/courses` | All courses |
| `GET` | `/api/v1/courses/:id` | Single course |
| `GET` | `/api/v1/semesters` | All semesters |
| `GET` | `/api/v1/semesters/:id` | Single semester |
| `GET` | `/api/v1/class_sessions` | All class sessions |
| `GET` | `/api/v1/class_sessions/:id` | Single class session with enrolled students & grades |

---

## Example Requests

```bash
# Get student profile
curl http://localhost:3000/api/v1/students/1

# Get a student's courses and grades
curl http://localhost:3000/api/v1/students/1/courses

# List all departments
curl http://localhost:3000/api/v1/departments

# List all class sessions
curl http://localhost:3000/api/v1/class_sessions
```

---

## Seed Data

The seed file (`db/seeds.rb`) creates:

- **5 departments**: English, Mathematics, Science, History, Computer Science
- **15 courses** (3 per department)
- **2 semesters**: Fall 2026, Spring 2027
- **8 teachers** (named after famous academics)
- **20 students**
- **16 class sessions** (8 per semester)
- **~128 enrollments** — Fall 2026 sessions have grades; Spring 2027 sessions are in progress (no grades yet)

After seeding, the console output will print sample student IDs you can use for testing.
