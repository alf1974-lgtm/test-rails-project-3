# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Data Model

```
User          — role: "student" | "teacher"
Department    — English, Mathematics, Science, History, Computer Science
Course        — belongs_to Department
Semester      — Fall 2026, Spring 2027
ClassSession  — belongs_to Course, Semester, teacher (User)
Enrollment    — joins ClassSession ↔ student (User), stores grade
```

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/v1/students/:id` | Student profile |
| `GET` | `/api/v1/students/:id/courses` | Student's enrolled class sessions with grades |

### Example: Get student profile

```
GET /api/v1/students/1
```

```json
{
  "id": 1,
  "first_name": "Liam",
  "last_name": "Chen",
  "full_name": "Liam Chen",
  "email": "liam.chen@students.school.edu",
  "role": "student"
}
```

### Example: Get student's courses

```
GET /api/v1/students/1/courses
```

```json
[
  {
    "enrollment_id": 1,
    "grade": "A-",
    "class_session": {
      "id": 3,
      "room": "303C",
      "schedule": "TTh 09:30-10:45",
      "course": {
        "id": 3,
        "name": "Calculus I",
        "code": "MAT101",
        "description": "Limits, derivatives, and integrals.",
        "department": "Mathematics"
      },
      "semester": {
        "id": 1,
        "name": "Fall 2026",
        "start_date": "2026-09-01",
        "end_date": "2026-12-20"
      },
      "teacher": {
        "id": 2,
        "full_name": "Bob Martinez",
        "email": "bob.martinez@school.edu"
      }
    }
  }
]
```

## Seed Data

The seed file creates:
- 5 departments
- 10 courses (2 per department)
- 2 semesters (Fall 2026, Spring 2027)
- 5 teachers
- 10 students
- 20 class sessions (each course × each semester)
- ~90 enrollments (each student in 4–6 sessions per semester; Fall 2026 grades assigned, Spring 2027 in-progress)
