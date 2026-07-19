# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Data Model

```
User (role: student | teacher)
Department
  └── Course (belongs_to Department)
Semester
ClassSession (belongs_to Course, Semester, teacher:User)
  └── Enrollment (belongs_to student:User, ClassSession) — holds grade
```

## API Endpoints

### Student-facing

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/students/:id` | Student profile |
| GET | `/api/v1/students/:id/courses` | All enrollments with grades, course & semester info |

### General / Admin

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/users` | All users |
| GET | `/api/v1/users/:id` | Single user |
| GET | `/api/v1/departments` | All departments (with courses) |
| GET | `/api/v1/departments/:id` | Single department |
| GET | `/api/v1/courses` | All courses |
| GET | `/api/v1/courses/:id` | Single course |
| GET | `/api/v1/semesters` | All semesters |
| GET | `/api/v1/semesters/:id` | Single semester |
| GET | `/api/v1/class_sessions` | All class sessions |
| GET | `/api/v1/class_sessions/:id` | Single class session (includes enrolled students) |
| GET | `/health` | Health check |

## Example Requests

```bash
# Get student info (student IDs start at 7 after 6 teachers are seeded)
curl http://localhost:3000/api/v1/students/7

# Get a student's courses
curl http://localhost:3000/api/v1/students/7/courses

# List all departments
curl http://localhost:3000/api/v1/departments

# List all class sessions
curl http://localhost:3000/api/v1/class_sessions
```

## Seed Data

The seed file creates:
- **6 departments**: English, Mathematics, Science, History, Computer Science, Physical Education
- **13 courses** spread across departments
- **2 semesters**: Fall 2026 and Spring 2027
- **6 teachers** (famous scientists/educators)
- **12 students**
- **12 class sessions** (6 per semester)
- **~80–100 enrollments** with grades for Fall 2026; Spring 2027 enrollments have no grade yet
