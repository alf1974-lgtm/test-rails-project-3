# test-rails-project-3

test-rails-project again with readme

---

## Coding Standards

These standards were finalized by the team and apply to all code in this repository.

### Rails Conventions

- Follow **RESTful routes and controllers** throughout — use the standard `index`, `show`, `new`, `create`, `edit`, `update`, and `destroy` actions, and avoid custom routes unless strictly necessary.
- Keep controllers **skinny**: move business logic into models or dedicated service objects rather than letting it accumulate in controller actions.

### Formatting (RuboCop-compliant)

- **2-space indentation** — no tabs.
- **`snake_case`** for all method and variable names.
- **`CamelCase`** for all class and module names.
- All code must pass RuboCop without offenses before merging.

### Data & Associations

- Use **strong parameters** for every controller action that writes to the database (`create`, `update`).
- Prefer **`has_many :through`** associations over manual join-table handling wherever a many-to-many relationship exists.

### Testing

- Every model and every API endpoint **must** have a corresponding RSpec test:
  - **Model specs** — cover validations and associations.
  - **Request specs** — cover all routes/endpoints.
- Use **FactoryBot** for test data; do not use fixtures.
- Write **meaningful edge-case coverage** in addition to happy-path tests — for example:
  - A student who is enrolled in no courses.
  - A `class_session` that has no grades recorded yet.
