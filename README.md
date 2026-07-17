# School API

A Rails 8 API for a school management system.

## Models

| Model | Description |
|---|---|
| `User` | Both students and teachers. Differentiated by `role` (`"student"` or `"teacher"`) |
| `Department` | Academic departments (English, Mathematics, Science, History, Computer Science) |
| `Course` | A course belonging to a department (e.g. `CS101 – Intro to Programming`) |
| `Semester` | A semester with a name, start date, and end date (e.g. `Fall 2026`, `Spring 2027`) |
| `ClassSession` | A specific offering of a course in a semester, taught by one teacher |
| `Enrollment` | Join table between a student and a class session; stores the student's `grade` |

## Associations

```
Department  ──< Course ──< ClassSession >── Semester
                                │
                           (teacher) User
                                │
                          Enrollment >── (student) User
```

## API Endpoints

| Method | Path | Description |
|---|---|---|
| `GET` | `/students/:id` | Get a student's profile (name, email, role) |
| `GET` | `/students/:id/courses` | Get all of a student's enrollments with course, semester, teacher, and grade |
| `GET` | `/up` | Health check |

### Example: `GET /students/1`

```json
{
  "id": 1,
  "first_name": "Alice",
  "last_name": "Johnson",
  "full_name": "Alice Johnson",
  "email": "alice.johnson@students.edu",
  "role": "student",
  "created_at": "2024-01-01T00:00:00.000Z"
}
```

### Example: `GET /students/1/courses`

```json
[
  {
    "enrollment_id": 1,
    "grade": "A",
    "class_session": {
      "id": 5,
      "room": "E505",
      "schedule": "MWF 14:00-14:50",
      "course": {
        "id": 11,
        "name": "Intro to Programming",
        "code": "CS101",
        "description": "Programming fundamentals using Python.",
        "department": "Computer Science"
      },
      "semester": {
        "id": 1,
        "name": "Fall 2026",
        "start_date": "2026-08-24",
        "end_date": "2026-12-18"
      },
      "teacher": {
        "id": 3,
        "full_name": "Ada Lovelace",
        "email": "a.lovelace@school.edu"
      }
    }
  }
]
```

> **Note:** `grade` is `null` for students currently enrolled but not yet graded.

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Seed Data

The seed file creates:
- **5 departments**: English, Mathematics, Science, History, Computer Science
- **12 courses** spread across departments
- **2 semesters**: Fall 2026 and Spring 2027
- **5 teachers**: Margaret Atwood, Richard Feynman, Ada Lovelace, Carl Sagan, Euclid of Alexandria
- **10 students**: Alice, Bob, Carol, David, Eva, Frank, Grace, Henry, Iris, James
- **13 class sessions** across both semesters
- **60 enrollments** with realistic grades (James Anderson is enrolled in Spring 2027 with no grades yet)
