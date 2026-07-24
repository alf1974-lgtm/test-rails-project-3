# School API

A Rails API for managing a school system with users (students and teachers), departments, courses, semesters, and class sessions.

## Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Create and migrate the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

3. Seed the database with sample data:
   ```bash
   rails db:seed
   ```

## Running Tests

Run all tests:
```bash
rspec
```

Run specific test file:
```bash
rspec spec/models/user_spec.rb
```

Run with verbose output:
```bash
rspec --format documentation
```

## API Endpoints

### Student Endpoints

- **Get student info by ID**
  ```
  GET /api/v1/students/:id
  ```
  Returns student information (name, email, role)

- **Get current student info**
  ```
  GET /api/v1/students/me?student_id=:id
  ```
  Returns current student information

- **Get student's courses**
  ```
  GET /api/v1/students/:student_id/courses
  ```
  Returns all courses the student is enrolled in, including department information

## Models

### User
- Attributes: name, email, role (student/teacher)
- Roles: student, teacher
- Associations: has_many enrollments, has_many class_sessions_as_teacher

### Department
- Attributes: name
- Associations: has_many courses

### Course
- Attributes: name, code, department_id
- Associations: belongs_to department, has_many class_sessions

### Semester
- Attributes: name
- Associations: has_many class_sessions

### ClassSession
- Attributes: course_id, semester_id, teacher_id
- Associations: belongs_to course, belongs_to semester, belongs_to teacher (User), has_many enrollments, has_many students

### Enrollment
- Attributes: user_id, class_session_id, grade
- Associations: belongs_to user, belongs_to class_session

## Database Schema

The database includes the following tables:
- users
- departments
- courses
- semesters
- class_sessions
- enrollments

## Example Usage

```bash
# Get a student's information
curl http://localhost:3000/api/v1/students/1

# Get current student info
curl http://localhost:3000/api/v1/students/me?student_id=1

# Get student's courses
curl http://localhost:3000/api/v1/students/1/courses
```

## Development

Start the Rails server:
```bash
rails s
```

The API will be available at `http://localhost:3000`
