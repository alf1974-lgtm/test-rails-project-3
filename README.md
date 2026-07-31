# School API

A Rails 7 API-only application for managing a school — departments, courses, semesters, teachers, students, and class sessions.

## Models

| Model | Description |
|---|---|
| `User` | Students and teachers (`role: "student"` or `"teacher"`) |
| `Department` | e.g. English, Math, Science, History, Computer Science |
| `Course` | Belongs to a department (e.g. ENG101, MATH101) |
| `Semester` | e.g. Fall 2026, Spring 2027 |
| `ClassSession` | A course offered in a semester, with one teacher and many students |
| `Enrollment` | Join table: student ↔ class_session, with a `grade` and `status` |

## Routes

```
GET /api/v1/students/:id           # Student profile
GET /api/v1/students/:id/courses   # All enrollments for a student
GET /up                            # Health check
```

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Example Requests

```bash
# Get student info (student id = 1)
curl http://localhost:3000/api/v1/students/1

# Get student's courses
curl http://localhost:3000/api/v1/students/1/courses
```

## Running Tests

```bash
bundle exec rspec
```

## Seed Data

The seed file creates:
- 5 departments (English, Mathematics, Science, History, Computer Science)
- 14 courses spread across departments
- 2 semesters (Fall 2026, Spring 2027)
- 6 teachers
- 10 students
- 16 class sessions (8 per semester)
- ~60 enrollments with grades for Fall 2026 and active enrollments for Spring 2027
