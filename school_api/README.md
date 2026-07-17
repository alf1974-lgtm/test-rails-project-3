# School API

A Rails 8 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

---

## Data Model

```
Department ──< Course ──< ClassSession >── Semester
                                │
                          teacher (User)
                                │
                         Enrollment >── student (User)
                                │
                              grade
```

| Model | Key fields |
|---|---|
| **User** | `first_name`, `last_name`, `email`, `role` (`student` \| `teacher`) |
| **Department** | `name` (English, Mathematics, Science, History, Computer Science) |
| **Course** | `name`, `code`, `credits`, `description`, `department_id` |
| **Semester** | `name`, `start_date`, `end_date` |
| **ClassSession** | `course_id`, `semester_id`, `teacher_id`, `room`, `schedule` |
| **Enrollment** | `student_id`, `class_session_id`, `grade` (A/A-/B+/… or nil = in progress) |

---

## Setup

```bash
cd school_api
bundle install
rails db:create db:migrate db:seed
```

The seed file creates:
- 5 departments
- 13 courses
- 2 semesters (Fall 2026, Spring 2027)
- 6 teachers
- 10 students
- 12 class sessions
- 43 enrollments (with grades for Fall 2026, in-progress for Spring 2027)

---

## Running the server

```bash
rails server
# → http://localhost:3000
```

---

## API Endpoints

### `GET /students/:id`
Returns a student's profile.

**Example response:**
```json
{
  "id": 7,
  "first_name": "Alice",
  "last_name": "Johnson",
  "full_name": "Alice Johnson",
  "email": "alice.johnson@students.edu",
  "role": "student",
  "created_at": "2024-01-01T00:00:00.000Z"
}
```

---

### `GET /students/:id/courses`
Returns all class sessions the student is enrolled in, including course details, semester, teacher, and grade.

**Example response:**
```json
{
  "student": { "id": 7, "name": "Alice Johnson" },
  "courses": [
    {
      "enrollment_id": 14,
      "grade": "A",
      "class_session": {
        "id": 11,
        "room": "CS  302",
        "schedule": "MWF 14:00-14:50",
        "course": {
          "id": 12,
          "name": "Data Structures",
          "code": "CSC201",
          "description": "Arrays, linked lists, trees, graphs, and algorithm analysis.",
          "credits": 3,
          "department": "Computer Science"
        },
        "semester": {
          "id": 2,
          "name": "Spring 2027",
          "start_date": "2027-01-11",
          "end_date": "2027-05-07"
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

Results are ordered by semester (most recent first), then course name alphabetically.

---

## Validations

- **User** – email uniqueness & format; role must be `student` or `teacher`
- **Course** – code uniqueness; credits > 0
- **Semester** – end date must be after start date
- **ClassSession** – teacher must have `role = "teacher"`
- **Enrollment** – student must have `role = "student"`; grade must be a valid letter grade or nil; a student cannot be enrolled in the same class session twice

---

## Project Structure

```
app/
  controllers/
    application_controller.rb   # rescue_from RecordNotFound → 404
    students_controller.rb      # show, courses
  models/
    user.rb
    department.rb
    course.rb
    semester.rb
    class_session.rb
    enrollment.rb
db/
  migrate/                      # 6 migrations
  seeds.rb                      # realistic seed data
config/
  routes.rb
```
