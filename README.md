# test-rails-project-3
test-rails-project again with readme

## Coding Standards

Please follow the guidelines below when contributing to this project.

### Rails Conventions

- Use **RESTful routes and controllers** throughout. Map resources with `resources` in `config/routes.rb` and keep controller actions aligned with standard CRUD verbs (`index`, `show`, `new`, `create`, `edit`, `update`, `destroy`).
- Keep controllers **skinny**: move business logic into models or dedicated service objects rather than letting it accumulate in controller actions.

### Code Formatting (Rubocop-compliant)

- **2-space indentation** — no tabs.
- **`snake_case`** for all method and variable names.
- **`CamelCase`** for all class and module names.
- Run `bundle exec rubocop` before opening a pull request and resolve all offences.

### Security & Data Integrity

- Always use **strong parameters** (`params.require(...).permit(...)`) for any controller action that writes to the database (`create`, `update`).

### Associations

- Prefer **`has_many :through`** associations over manual join-table handling wherever a many-to-many relationship exists.

### Testing

- Every model and every API endpoint **must** have a corresponding RSpec test:
  - **Model specs** — cover validations and associations.
  - **Request specs** — cover every route/endpoint.
- Use **FactoryBot** for test data instead of fixtures.
- Aim for **meaningful edge-case coverage**, not just happy-path tests. Examples include:
  - A student who is not enrolled in any courses.
  - A `class_session` that has no grades recorded yet.
