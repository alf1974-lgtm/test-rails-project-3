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
| `User` | Both students (`role: "student"`) and teachers (`role: "teacher"`) |
| `Department` | English, Mathematics, Science, History, Computer Science |
| `Course` | Belongs to a Department (e.g. ENG101 – Composition I) |
| `Semester` | Fall 2026, Spring 2027 |
| `ClassSession` | A course offered in a semester, taught by one teacher |
| `Enrollment` | Join between a student and a class session; stores `grade` |

## Routes

### Student-facing

| Method | Path | Description |
|---|---|---|
| `GET` | `/students/:id` | Student profile (name, email, role) |
| `GET` | `/students/:id/courses` | All class sessions the student is enrolled in, with grades |

### Reference (read-only)

| Method | Path | Description |
|---|---|---|
| `GET` | `/users` | All users |
| `GET` | `/departments` | All departments |
| `GET` | `/courses` | All courses |
| `GET` | `/semesters` | All semesters |
| `GET` | `/class_sessions` | All class sessions |

## Example Responses

### `GET /students/1`

```json
{
  "id": 1,
  "first_name": "Alice",
  "last_name": "Johnson",
  "full_name": "Alice Johnson",
  "email": "alice.johnson@school.edu",
  "role": "student"
}
```

### `GET /students/1/courses`

```json
[
  {
    "enrollment_id": 1,
    "grade": "A",
    "class_session_id": 1,
    "room": "A101",
    "schedule": "MWF 09:00-10:00",
    "course": {
      "id": 1,
      "name": "Composition I",
      "code": "ENG101",
      "description": "Introduction to academic writing",
      "department": "English"
    },
    "semester": {
      "id": 1,
      "name": "Fall 2026",
      "start_date": "2026-09-01",
      "end_date": "2026-12-20"
    },
    "teacher": {
      "id": 6,
      "full_name": "Margaret Atwood",
      "email": "m.atwood@school.edu"
    }
  }
]
```

## Seed Data

The seed file creates:
- **5 departments**: English, Mathematics, Science, History, Computer Science
- **10 courses** (2 per department)
- **2 semesters**: Fall 2026, Spring 2027
- **5 teachers** (one per subject area)
- **10 students**
- **10 class sessions** (one per course/semester pair)
- **~40 enrollments** with grades

After seeding, Alice Johnson (the first student) has predictable enrollments for easy testing.
