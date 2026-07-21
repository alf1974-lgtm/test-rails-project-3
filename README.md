# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server          # starts on http://localhost:3000
```

## Data Model

```
User (role: student | teacher)
  ├── has_many :enrollments          (as student)
  ├── has_many :class_sessions       (through enrollments, as student)
  └── has_many :taught_sessions      (as teacher → ClassSession)

Department
  └── has_many :courses

Course
  ├── belongs_to :department
  └── has_many :class_sessions

Semester
  └── has_many :class_sessions

ClassSession
  ├── belongs_to :course
  ├── belongs_to :semester
  ├── belongs_to :teacher  (User with role "teacher")
  ├── has_many :enrollments
  └── has_many :students   (through enrollments)

Enrollment  ← join table: student ↔ class_session
  ├── belongs_to :class_session
  ├── belongs_to :student  (User with role "student")
  └── grade  (string, e.g. "A", "B+", nil if not yet graded)
```

## API Endpoints

### Student Profile

```
GET /api/v1/students/:id
```

Returns the student's profile.

**Response 200**
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

**Response 404** — if the id doesn't exist or belongs to a teacher.

---

### Student Courses

```
GET /api/v1/students/:id/courses
```

Returns the student's profile plus all their enrollments (with course, semester, teacher, and grade info).

**Response 200**
```json
{
  "student": { "id": 1, "full_name": "Alice Johnson", ... },
  "enrollments": [
    {
      "enrollment_id": 3,
      "grade": "A",
      "class_session": {
        "id": 5,
        "room": "E505",
        "schedule": "MWF 14:00-14:50",
        "course": {
          "id": 9,
          "name": "Intro to Programming",
          "code": "CS101",
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

The seed file creates:

| Resource       | Count |
|----------------|-------|
| Departments    | 5     |
| Courses        | 10    |
| Semesters      | 2     |
| Teachers       | 5     |
| Students       | 8     |
| Class Sessions | 10    |
| Enrollments    | ~33   |

**Semesters:** Fall 2026 (Aug 24 – Dec 15) and Spring 2027 (Jan 19 – May 10).

Fall 2026 enrollments have grades assigned; Spring 2027 enrollments have `grade: null` (in progress).

After seeding, the console will print each student's ID so you can use them in API calls.

## Running Tests

```bash
bundle exec rspec
```
