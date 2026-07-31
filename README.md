# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Data Model

| Model | Description |
|---|---|
| `User` | Both students and teachers (`role: "student"` or `"teacher"`) |
| `Department` | English, Mathematics, Science, History, Computer Science |
| `Course` | Belongs to a department; has a code (e.g. `ENG101`) and credit count |
| `Semester` | Named period with start/end dates (e.g. "Fall 2026") |
| `ClassSession` | A course offered in a semester, taught by one teacher |
| `Enrollment` | Join between a student and a class session; stores the student's grade |

## API Routes

### Student-facing

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/v1/students/:id` | Student profile |
| `GET` | `/api/v1/students/:id/courses` | All enrollments with course, semester, teacher, and grade |

### General / Admin

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/v1/users` | All users |
| `GET` | `/api/v1/users/:id` | Single user |
| `GET` | `/api/v1/departments` | All departments (with courses) |
| `GET` | `/api/v1/departments/:id` | Single department |
| `GET` | `/api/v1/courses` | All courses |
| `GET` | `/api/v1/courses/:id` | Single course |
| `GET` | `/api/v1/semesters` | All semesters |
| `GET` | `/api/v1/semesters/:id` | Single semester |
| `GET` | `/api/v1/class_sessions` | All class sessions |
| `GET` | `/api/v1/class_sessions/:id` | Single class session (includes enrolled students + grades) |

## Example Requests

```bash
# Get student #1's profile
curl http://localhost:3000/api/v1/students/1

# Get student #1's courses
curl http://localhost:3000/api/v1/students/1/courses

# List all departments
curl http://localhost:3000/api/v1/departments

# See who's in class session #3
curl http://localhost:3000/api/v1/class_sessions/3
```

## Seed Data

Running `rails db:seed` creates:
- 5 departments
- 12 courses
- 2 semesters (Fall 2026, Spring 2027)
- 5 teachers
- 12 students
- 10 class sessions (5 per semester)
- ~72 enrollments (each student in 3 sessions per semester), with grades assigned for Fall and partial grades for Spring
