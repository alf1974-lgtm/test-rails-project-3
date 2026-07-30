# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Models

| Model | Description |
|---|---|
| `User` | A person with `role: "student"` or `role: "teacher"` |
| `Department` | e.g. English, Math, Science, History, Computer Science |
| `Course` | Belongs to a Department (e.g. Calculus I – MTH101) |
| `Semester` | e.g. Fall 2026, Spring 2027 |
| `ClassSession` | A Course offered in a Semester, taught by one Teacher |
| `Enrollment` | Join between a Student and a ClassSession; stores `grade` |

### Relationships

```
Department ──< Course ──< ClassSession >── Semester
                               │
                          Teacher (User)
                               │
                         Enrollment >── Student (User)
                          (+ grade)
```

## Setup

```bash
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
```

## API Endpoints

### Get a student's profile

```
GET /students/:id
```

**Response**
```json
{
  "id": 1,
  "name": "Sam Torres",
  "email": "sam.torres@students.edu",
  "role": "student"
}
```

### Get a student's courses (all semesters)

```
GET /students/:id/courses
```

**Response** — array of enrollments, each with semester, course, class session, teacher, and grade:

```json
[
  {
    "enrollment_id": 1,
    "grade": "A",
    "semester": { "id": 1, "name": "Fall 2026" },
    "course": {
      "id": 9,
      "name": "Intro to Programming",
      "code": "CS101",
      "description": "Programming fundamentals using Python.",
      "department": "Computer Science"
    },
    "class_session": { "id": 1, "room": "Tech 101", "schedule": "MWF 9:00-9:50" },
    "teacher": { "id": 1, "name": "Dr. Alice Monroe" }
  }
]
```

## Seed Data

Running `db:seed` creates:

- **5 departments**: English, Math, Science, History, Computer Science
- **10 courses** (2 per department)
- **2 semesters**: Fall 2026, Spring 2027
- **5 teachers**
- **8 students**
- **10 class sessions** (5 per semester)
- **~30 enrollments** with grades for Fall 2026 and pending grades for Spring 2027
