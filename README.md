# School API

A simple Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Data Model

```
User          – role: "student" | "teacher"
Department    – English, Math, Science, History, Computer Science
Course        – belongs_to :department
Semester      – Fall 2026, Spring 2027
ClassSession  – belongs_to :course, :semester, :teacher (User)
Enrollment    – belongs_to :class_session, :student (User); has a :grade string
```

## API Endpoints

All routes are namespaced under `/api/v1`.

### Get a student's info

```
GET /api/v1/students/:id
```

**Response**
```json
{
  "id": 1,
  "name": "Emma Johnson",
  "email": "emma.johnson@students.edu",
  "role": "student"
}
```

### Get a student's courses

```
GET /api/v1/students/:id/courses
```

Returns all class sessions the student is enrolled in, including course details, semester, teacher, and grade.

**Response**
```json
[
  {
    "class_session_id": 1,
    "course": {
      "id": 1,
      "name": "Composition I",
      "code": "ENG101",
      "department": "English"
    },
    "semester": {
      "id": 1,
      "name": "Fall 2026",
      "start_date": "2026-09-01",
      "end_date": "2026-12-20"
    },
    "teacher": {
      "id": 9,
      "name": "Alice Smith"
    },
    "grade": "A"
  }
]
```

## Seed Data

The seed file creates:
- 5 departments
- 2 semesters (Fall 2026, Spring 2027)
- 10 courses (2 per department)
- 5 teachers
- 8 students
- 10 class sessions (5 per semester)
- ~40 enrollments (each student in 5 sessions; Fall grades assigned, Spring grades pending)
