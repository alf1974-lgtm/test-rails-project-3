# School API

A Rails 8 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

---

## Models

```
User          — students and teachers (role: "student" | "teacher")
Department    — e.g. English, Mathematics, Science, History, Computer Science
Course        — belongs to a Department (has a code, name, credits)
Semester      — e.g. "Fall 2026", "Spring 2027"
ClassSession  — a Course offered in a Semester, taught by one Teacher
Enrollment    — join between a Student and a ClassSession; stores the grade
```

### Relationships

```
Department  has_many  Courses
Course      has_many  ClassSessions
Semester    has_many  ClassSessions
User(teacher) has_many ClassSessions (as teacher)
ClassSession  has_many Enrollments
User(student) has_many Enrollments → ClassSessions (as student)
Enrollment    belongs_to ClassSession, belongs_to User(student)
```

---

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/v1/students/:id` | Get a student's profile |
| `GET` | `/api/v1/students/:id/courses` | Get all class sessions a student is enrolled in |
| `GET` | `/up` | Health check |

### GET /api/v1/students/:id

Returns the student's profile.

```json
{
  "id": 6,
  "first_name": "Alice",
  "last_name": "Johnson",
  "full_name": "Alice Johnson",
  "email": "alice.johnson@school.edu",
  "role": "student",
  "created_at": "2024-01-01T00:00:00.000Z"
}
```

### GET /api/v1/students/:id/courses

Returns all enrollments for the student, ordered by semester (newest first) then course name.

```json
[
  {
    "enrollment_id": 1,
    "grade": "A",
    "class_session": {
      "id": 1,
      "room": "Humanities 101",
      "schedule": "MWF 9:00-9:50am",
      "course": {
        "id": 1,
        "name": "Composition I",
        "code": "ENG101",
        "description": "Introduction to academic writing and rhetoric.",
        "credits": 3,
        "department": "English"
      },
      "semester": {
        "id": 1,
        "name": "Fall 2026",
        "start_date": "2026-08-24",
        "end_date": "2026-12-15"
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

---

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

---

## Seed Data

The seed file creates:

| Resource | Count |
|----------|-------|
| Departments | 5 (English, Mathematics, Science, History, Computer Science) |
| Courses | 10 (2 per department) |
| Semesters | 2 (Fall 2026, Spring 2027) |
| Teachers | 5 |
| Students | 10 |
| Class Sessions | 10 (5 per semester) |
| Enrollments | 44 (Fall 2026 grades assigned; Spring 2027 grades pending) |

After seeding, check the student IDs printed at the end of `db:seed` output and use them in the API calls.

---

## Example Requests

```bash
# Get student profile (replace 6 with actual ID from seed output)
curl http://localhost:3000/api/v1/students/6

# Get student's courses
curl http://localhost:3000/api/v1/students/6/courses

# Non-existent student → 404
curl http://localhost:3000/api/v1/students/9999
```
