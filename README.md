# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Models

| Model | Description |
|---|---|
| `User` | Both students and teachers (`role: "student"` or `"teacher"`) |
| `Department` | e.g. English, Math, Science, History, Computer Science |
| `Course` | Belongs to a Department (e.g. Calculus I, CS101) |
| `Semester` | e.g. Fall 2026, Spring 2027 |
| `ClassSession` | A specific offering of a Course in a Semester, taught by one teacher |
| `Enrollment` | Join table: a student in a ClassSession, with a grade |

## API Routes

### Student Routes

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/v1/students/:id` | Get a student's profile |
| `GET` | `/api/v1/students/:id/courses` | Get all courses a student is enrolled in, grouped by semester |

### Browse Routes

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/v1/departments` | List all departments |
| `GET` | `/api/v1/departments/:id` | Get a department with its courses |
| `GET` | `/api/v1/courses` | List all courses |
| `GET` | `/api/v1/courses/:id` | Get a course |
| `GET` | `/api/v1/semesters` | List all semesters |
| `GET` | `/api/v1/semesters/:id` | Get a semester |
| `GET` | `/api/v1/class_sessions` | List all class sessions |
| `GET` | `/api/v1/class_sessions/:id` | Get a class session with enrolled students |

## Example Requests

```bash
# Get student profile (Alice is student ID 1 after seeding)
curl http://localhost:3000/api/v1/students/1

# Get all courses for a student
curl http://localhost:3000/api/v1/students/1/courses

# List departments
curl http://localhost:3000/api/v1/departments

# List all class sessions
curl http://localhost:3000/api/v1/class_sessions
```

## Seed Data

The seed file creates:
- **5 departments**: English, Mathematics, Science, History, Computer Science
- **12 courses** spread across departments
- **2 semesters**: Fall 2026 (completed) and Spring 2027 (in progress)
- **5 teachers** (named after famous academics)
- **10 students** (Alice through Jack)
- **12 class sessions** (7 in Fall 2026, 5 in Spring 2027)
- **~45 enrollments** with grades for Fall 2026 and active enrollments for Spring 2027

After seeding, run `rails db:seed` and check the output — it prints each student's ID so you know which IDs to use in API calls.
