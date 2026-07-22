# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Setup

```bash
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
```

## Models

| Model | Description |
|---|---|
| `User` | Both students and teachers. Differentiated by `role` (`"student"` \| `"teacher"`) |
| `Department` | English, Mathematics, Science, History, Computer Science |
| `Course` | Belongs to a `Department`. Has a short code (e.g. `ENG101`) |
| `Semester` | e.g. *Fall 2026*, *Spring 2027* |
| `ClassSession` | A specific offering of a `Course` in a `Semester`, taught by one teacher |
| `Enrollment` | Join between a student (`User`) and a `ClassSession`; carries the student's `grade` |

### Relationships

```
Department ──< Course ──< ClassSession >── Semester
                               │
                          (teacher) User
                               │
                          Enrollment >── (student) User
```

## API Endpoints

All routes are prefixed with `/api/v1`.

### Student Profile

```
GET /api/v1/students/:id
```

Returns the student's basic info.

**Example response:**
```json
{
  "id": 1,
  "first_name": "Alice",
  "last_name": "Johnson",
  "full_name": "Alice Johnson",
  "email": "alice.johnson@students.edu",
  "role": "student"
}
```

---

### Student Courses

```
GET /api/v1/students/:id/courses
```

Returns all class sessions the student is enrolled in, with course, semester, teacher, and grade info.

**Example response:**
```json
{
  "student": { "id": 1, "name": "Alice Johnson" },
  "enrollments": [
    {
      "enrollment_id": 1,
      "grade": "A",
      "class_session": {
        "id": 5,
        "room": "Tech 105",
        "schedule": "MWF 1:00-1:50",
        "course": {
          "id": 13,
          "name": "Intro to Programming",
          "code": "CS101",
          "credits": 3,
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
}
```

## Seed Data

The seed file (`db/seeds.rb`) creates:

- **5 departments**: English, Mathematics, Science, History, Computer Science
- **15 courses** spread across departments
- **2 semesters**: Fall 2026 and Spring 2027
- **5 teachers** (one per department)
- **10 students** with varied course loads
- **15 class sessions** across both semesters
- **50+ enrollments** with grades (some in-progress with `null` grade)

After seeding, the console will print each student's ID so you can use them in API calls.
