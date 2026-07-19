# School API — Rails 8 API Project

A simple Rails 8 API for a school management system, built with SQLite.

## Models

| Model | Description |
|---|---|
| `User` | Students and teachers (`role: "student"` or `"teacher"`) |
| `Department` | English, Math, Science, History |
| `Course` | Belongs to a Department |
| `Semester` | Fall 2026, Spring 2027 |
| `ClassSession` | A course offered in a semester, taught by one teacher |
| `Enrollment` | Join table: a student in a class session, with a grade (A–F) |

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## API Endpoints

### `GET /students/:id`
Returns a student's basic info.

**Example:** `GET /students/5`
```json
{
  "id": 5,
  "name": "Emma Thompson",
  "email": "emma.thompson@students.edu",
  "role": "student"
}
```

### `GET /students/:id/courses`
Returns all class sessions the student is enrolled in, with course, department, semester, teacher, and grade.

**Example:** `GET /students/5/courses`
```json
{
  "student": { "id": 5, "name": "Emma Thompson", "email": "emma.thompson@students.edu" },
  "courses": [
    {
      "enrollment_id": 1,
      "grade": "A",
      "class_session_id": 1,
      "semester": { "id": 1, "name": "Fall 2026" },
      "course": {
        "id": 1,
        "name": "English 101",
        "department": { "id": 1, "name": "English" }
      },
      "teacher": { "id": 1, "name": "Ms. Alice Johnson" }
    }
  ]
}
```

## Seed Data

- 4 departments (English, Math, Science, History)
- 8 courses (2 per department)
- 2 semesters (Fall 2026, Spring 2027)
- 4 teachers
- 10 students
- 10 class sessions
- ~39 enrollments with grades
