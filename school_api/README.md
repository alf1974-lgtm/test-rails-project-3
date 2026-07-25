# School API

A Rails 7 API-only application for a school management system, built as a learning/demo project.

## Models

| Model | Description |
|---|---|
| `User` | Students and teachers (`role: "student"` or `"teacher"`) |
| `Department` | Academic departments (English, Math, Science, History, CS) |
| `Course` | A course belonging to a department (e.g. ENG101) |
| `Semester` | A semester (Fall 2026, Spring 2027) |
| `ClassSession` | A specific offering of a course in a semester, with one teacher |
| `Enrollment` | Join table: a student in a class session, with an optional grade |

## Setup

```bash
cd school_api
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
```

## API Endpoints

### Student Routes

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/v1/students/:id` | Get a student's profile |
| `GET` | `/api/v1/students/:id/courses` | Get all courses a student is enrolled in (with grades) |

### Supporting Routes

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/v1/departments` | List all departments |
| `GET` | `/api/v1/departments/:id` | Get a department with its courses |
| `GET` | `/api/v1/courses` | List all courses |
| `GET` | `/api/v1/courses/:id` | Get a course |
| `GET` | `/api/v1/semesters` | List all semesters |
| `GET` | `/api/v1/semesters/:id` | Get a semester |
| `GET` | `/api/v1/class_sessions` | List all class sessions |
| `GET` | `/api/v1/class_sessions/:id` | Get a class session with enrolled students and grades |

## Example Requests

```bash
# Get student profile (Alice Johnson is student id=1 after seeding)
curl http://localhost:3000/api/v1/students/1

# Get all courses Alice is enrolled in
curl http://localhost:3000/api/v1/students/1/courses

# List all departments
curl http://localhost:3000/api/v1/departments

# List all courses
curl http://localhost:3000/api/v1/courses
```

## Example Response: `GET /api/v1/students/1/courses`

```json
[
  {
    "enrollment_id": 1,
    "grade": "A-",
    "class_session": {
      "id": 1,
      "room": "Humanities 101",
      "schedule": "MWF 9:00-9:50",
      "course": {
        "id": 1,
        "code": "ENG101",
        "name": "Composition I",
        "credits": 3,
        "department": "English"
      },
      "semester": {
        "id": 1,
        "name": "Fall 2026",
        "start_date": "2026-08-24",
        "end_date": "2026-12-18"
      },
      "teacher": {
        "id": 1,
        "full_name": "Margaret Atwood",
        "email": "m.atwood@school.edu"
      }
    }
  }
]
```

## Seed Data

After running `db:seed` you'll have:
- **5 departments**: English, Mathematics, Science, History, Computer Science
- **14 courses** spread across departments
- **2 semesters**: Fall 2026 and Spring 2027
- **5 teachers**: Margaret Atwood, Richard Feynman, Ada Lovelace, Carl Sagan, Euclid
- **10 students**: Alice Johnson, Bob Smith, Carol Williams, and 7 more
- **14 class sessions** (8 in Fall 2026, 6 in Spring 2027)
- **~60 enrollments** with grades
