# School API

A Rails 8 API-only application for a school management system, built as a learning/testing project.

## Stack

- **Ruby on Rails 8.1** (API mode)
- **SQLite3** (development & test)
- **rack-cors** for CORS headers

## Data Model

```
User          — name, email, role ("student" | "teacher")
Department    — name
Course        — name, code, belongs_to Department
Semester      — name  (e.g. "Fall 2026", "Spring 2027")
ClassSession  — belongs_to Course, Semester, teacher (User)
Enrollment    — belongs_to ClassSession, student (User); has grade
```

## Setup

```bash
cd school_api
bundle install
rails db:create db:migrate db:seed
rails server
```

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/students/:id` | Get a student's profile |
| `GET` | `/students/:id/courses` | Get all enrollments (with grades) for a student |
| `GET` | `/up` | Health check |

### Example responses

**GET /students/1**
```json
{
  "id": 1,
  "name": "Jordan Rivera",
  "email": "jordan.rivera@students.edu",
  "role": "student"
}
```

**GET /students/1/courses**
```json
[
  {
    "enrollment_id": 1,
    "grade": "A",
    "class_session": {
      "id": 5,
      "course": {
        "id": 9,
        "name": "Intro to Programming",
        "code": "CS101",
        "department": "Computer Science"
      },
      "semester": { "id": 1, "name": "Fall 2026" },
      "teacher": { "id": 5, "name": "Dr. Eva Brown", "email": "eva.brown@school.edu" }
    }
  }
]
```

## Seed Data

The seed file (`db/seeds.rb`) creates:

- **2 semesters**: Fall 2026, Spring 2027
- **5 departments**: English, Math, Science, History, Computer Science
- **10 courses** (2 per department)
- **5 teachers** and **8 students**
- **10 class sessions** (one per course, spread across both semesters)
- **37 enrollments** with grades for Fall 2026 and pending (nil) for Spring 2027
