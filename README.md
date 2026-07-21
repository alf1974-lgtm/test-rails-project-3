# School API

A Rails 7.1 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Models

| Model | Description |
|---|---|
| `User` | Both students and teachers. Differentiated by `role` (`"student"` or `"teacher"`) |
| `Department` | Academic departments (English, Mathematics, Science, History, Computer Science) |
| `Course` | A course belonging to a department (e.g. ENG101 – Composition I) |
| `Semester` | A term (Fall 2026, Spring 2027) with start/end dates |
| `ClassSession` | A specific offering of a course in a semester, taught by one teacher |
| `Enrollment` | Join table between a student and a class session; stores the student's `grade` |

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
rails db:create db:migrate db:seed
```

## Running the server

```bash
rails server
# or
rails s -p 3000
```

## API Endpoints

### `GET /api/v1/students/:id`

Returns a student's profile.

**Example response:**
```json
{
  "id": 1,
  "first_name": "Alice",
  "last_name": "Johnson",
  "full_name": "Alice Johnson",
  "email": "alice.johnson@student.edu",
  "role": "student"
}
```

---

### `GET /api/v1/students/:id/courses`

Returns all class sessions the student is enrolled in, with course, semester, teacher, and grade information.

**Example response:**
```json
{
  "student": {
    "id": 1,
    "first_name": "Alice",
    "last_name": "Johnson",
    "full_name": "Alice Johnson",
    "email": "alice.johnson@student.edu",
    "role": "student"
  },
  "enrollments": [
    {
      "enrollment_id": 1,
      "grade": "A",
      "class_session": {
        "id": 6,
        "room": "CS 110",
        "schedule": "TTh 3:00-4:15pm",
        "course": {
          "id": 11,
          "name": "Intro to Programming",
          "code": "CSC101",
          "credits": 3,
          "department": "Computer Science"
        },
        "semester": {
          "id": 1,
          "name": "Fall 2026",
          "start_date": "2026-08-24",
          "end_date": "2026-12-15"
        },
        "teacher": {
          "id": 6,
          "full_name": "Grace Hopper",
          "email": "g.hopper@school.edu"
        }
      }
    }
  ]
}
```

## Seed Data

Running `rails db:seed` creates:

- **5 departments**: English, Mathematics, Science, History, Computer Science
- **2 semesters**: Fall 2026, Spring 2027
- **13 courses** spread across departments
- **6 teachers** (Margaret Atwood, Richard Feynman, Ada Lovelace, Carl Sagan, Howard Zinn, Grace Hopper)
- **10 students** (Alice Johnson, Bob Smith, Carol Williams, …)
- **13 class sessions** (7 in Fall 2026, 6 in Spring 2027)
- **~45 enrollments** with grades for Fall 2026 sessions and `null` grades for in-progress Spring 2027 sessions

After seeding, the console will print each student's ID so you can immediately try the API:

```
GET http://localhost:3000/api/v1/students/1
GET http://localhost:3000/api/v1/students/1/courses
```

## Running Tests

```bash
rails test
```
