# School API

A Rails 8 API for a school management system.

## Models

| Model | Description |
|-------|-------------|
| `User` | Students and teachers (`role: "student"` or `"teacher"`) |
| `Department` | Academic departments (English, Math, Science, History) |
| `Course` | A course belonging to a department (e.g. ENG101 - English Composition) |
| `Semester` | A semester (e.g. Fall 2026, Spring 2027) |
| `ClassSession` | A specific offering of a course in a semester, taught by one teacher |
| `Enrollment` | A student enrolled in a class session, with an optional grade |

## Relationships

```
Department ──< Course ──< ClassSession >── Semester
                               │
                          Teacher (User)
                               │
                          Enrollment >── Student (User)
                               │
                             grade
```

## API Endpoints

### `GET /students/:id`
Returns a student's profile.

**Response:**
```json
{
  "id": 1,
  "name": "Emma Johnson",
  "email": "emma.johnson@school.edu",
  "role": "student"
}
```

### `GET /students/:id/class_sessions`
Returns all class sessions a student is enrolled in, with course, semester, teacher, and grade info.

**Response:**
```json
[
  {
    "enrollment_id": 1,
    "grade": "A",
    "class_session": {
      "id": 1,
      "course": {
        "id": 1,
        "name": "English Composition",
        "code": "ENG101",
        "description": "Fundamentals of academic writing",
        "department": { "id": 1, "name": "English" }
      },
      "semester": {
        "id": 1,
        "name": "Fall 2026",
        "season": "Fall",
        "year": 2026
      },
      "teacher": {
        "id": 5,
        "name": "Alice Smith",
        "email": "alice.smith@school.edu"
      }
    }
  }
]
```

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Seed Data

The seeds create:
- 2 semesters: Fall 2026, Spring 2027
- 4 departments: English, Math, Science, History
- 8 courses (2 per department)
- 4 teachers
- 10 students
- 8 class sessions (one per course, split across both semesters)
- ~48 enrollments (students randomly assigned to sessions)
