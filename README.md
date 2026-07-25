# School API

A Rails 7 API-only application for a school management system.

## Models

| Model | Description |
|---|---|
| `User` | Students and teachers (`role: "student"` or `"teacher"`) |
| `Department` | Academic departments (English, Math, Science, History, CS) |
| `Course` | A course belonging to a department |
| `Semester` | A semester (e.g. Fall 2026, Spring 2027) |
| `ClassSession` | A specific offering of a course in a semester, with one teacher |
| `Enrollment` | Join between a student and a class session; stores the grade |

## Setup

```bash
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
```

## API Endpoints

### Get a student's profile

```
GET /api/v1/students/:id
```

**Response:**
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

### Get a student's courses

```
GET /api/v1/students/:id/courses
```

Returns all class sessions the student is enrolled in, ordered by most recent semester first. Includes course details, semester, teacher, and the student's grade (null if not yet graded).

**Response:**
```json
[
  {
    "enrollment_id": 4,
    "grade": null,
    "class_session": {
      "id": 10,
      "room": "ENG 302",
      "schedule": "MWF 14:00-14:50",
      "course": {
        "id": 10,
        "name": "Data Structures",
        "code": "CS201",
        "credits": 3,
        "department": "Computer Science"
      },
      "semester": {
        "id": 2,
        "name": "Spring 2027",
        "start_date": "2027-01-19",
        "end_date": "2027-05-10"
      },
      "teacher": {
        "id": 5,
        "full_name": "Ada Lovelace",
        "email": "a.lovelace@school.edu"
      }
    }
  }
]
```

## Seed Data

The seed file creates:
- 5 departments (English, Mathematics, Science, History, Computer Science)
- 10 courses (2 per department)
- 2 semesters (Fall 2026, Spring 2027)
- 5 teachers
- 8 students
- 10 class sessions (5 per semester)
- ~40 enrollments with grades for Fall 2026 and pending for Spring 2027

Run `bin/rails db:seed` to see the student IDs printed to the console for easy testing.
