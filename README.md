# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Models

| Model | Description |
|---|---|
| `User` | Both students and teachers. Differentiated by `role` (`"student"` \| `"teacher"`) |
| `Department` | e.g. English, Mathematics, Science, History, Computer Science |
| `Course` | Belongs to a `Department`. Has a `course_code` (e.g. `ENG101`) |
| `Semester` | e.g. *Fall 2026*, *Spring 2027* |
| `ClassSession` | A specific offering of a `Course` in a `Semester`, taught by one `teacher` |
| `Enrollment` | Join table between `ClassSession` and a student `User`. Stores the `grade` |

### Relationships

```
Department ──< Course ──< ClassSession >── Semester
                               │
                          Enrollment
                         /          \
                    Student         grade
```

## Setup

### Prerequisites

- Ruby 3.2.2
- PostgreSQL
- Bundler

### Install & run

```bash
# 1. Install gems
bundle install

# 2. Configure database (copy and edit as needed)
cp .env.example .env

# 3. Create DB, run migrations, and seed
bin/rails db:create db:migrate db:seed

# 4. Start the server
bin/rails server
# → http://localhost:3000
```

## API Endpoints

### Student-facing routes

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/v1/students/:id` | Student profile |
| `GET` | `/api/v1/students/:id/courses` | All class sessions the student is enrolled in, with grades |

#### Example — student profile

```
GET /api/v1/students/1
```

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

#### Example — student courses

```
GET /api/v1/students/1/courses
```

```json
[
  {
    "enrollment_id": 1,
    "grade": "A",
    "class_session": {
      "id": 8,
      "room": "Tech 201",
      "schedule": "TTh 3:00-4:15",
      "course": {
        "id": 12,
        "name": "Intro to Programming",
        "course_code": "CS101",
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
```

### General / admin routes

| Method | Path | Description |
|---|---|---|
| `GET/POST` | `/api/v1/users` | List / create users |
| `GET/PATCH/DELETE` | `/api/v1/users/:id` | Show / update / delete a user |
| `GET/POST` | `/api/v1/departments` | List / create departments |
| `GET/PATCH/DELETE` | `/api/v1/departments/:id` | Show / update / delete |
| `GET/POST` | `/api/v1/courses` | List / create courses |
| `GET/PATCH/DELETE` | `/api/v1/courses/:id` | Show / update / delete |
| `GET/POST` | `/api/v1/semesters` | List / create semesters |
| `GET/PATCH/DELETE` | `/api/v1/semesters/:id` | Show / update / delete |
| `GET/POST` | `/api/v1/class_sessions` | List / create class sessions |
| `GET/PATCH/DELETE` | `/api/v1/class_sessions/:id` | Show / update / delete |
| `GET` | `/api/v1/class_sessions/:id/roster` | All students + grades in a session |
| `POST` | `/api/v1/class_sessions/:id/enroll` | Enroll a student (`{ student_id: N }`) |
| `PATCH` | `/api/v1/class_sessions/:id/update_grade` | Set a grade (`{ student_id: N, grade: "B+" }`) |

## Seed data

The seed file creates:

- **5 departments**: English, Mathematics, Science, History, Computer Science
- **14 courses** spread across departments
- **2 semesters**: Fall 2026 and Spring 2027
- **5 teachers**: Margaret Atwood, Richard Feynman, Ada Lovelace, Carl Sagan, Howard Zinn
- **12 students**: Alice, Bob, Carol, David, Eva, Frank, Grace, Henry, Iris, James, Karen, Leo
- **15 class sessions** across both semesters
- **~60 enrollments** with grades for Fall 2026 and pending grades for Spring 2027

After seeding, the console output will print sample student IDs you can use immediately.

## Tests

```bash
bundle exec rspec
```
