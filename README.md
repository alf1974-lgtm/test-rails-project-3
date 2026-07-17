# test-rails-project-3
test-rails-project again with readme

---

## Coding Standards

These standards were finalized by the team and should be followed consistently across the entire codebase.

### Rails Conventions

- Follow **RESTful routing and controller design** throughout. Resources should map cleanly to the seven standard Rails actions (`index`, `show`, `new`, `create`, `edit`, `update`, `destroy`); add custom actions only when no standard action fits.
- Keep controllers **skinny**: move business logic into models or dedicated service objects. Controllers are responsible for receiving a request, delegating work, and rendering a response — nothing more.
- Use **strong parameters** for every write operation (`create`, `update`). Never pass `params` directly to a model method.
- Prefer **`has_many :through` associations** over manual join-table handling wherever a many-to-many relationship exists.

### Code Formatting (RuboCop-compliant)

- **2-space indentation** — no tabs.
- **`snake_case`** for all method and variable names.
- **`CamelCase`** for all class and module names.
- All code must pass RuboCop with the project's shared `.rubocop.yml` configuration before merging.

### Testing

- Every **model** must have a corresponding RSpec model spec covering validations and associations.
- Every **API endpoint / route** must have a corresponding RSpec request spec.
- Use **FactoryBot** for all test data — do not use fixtures.
- Write tests that cover **meaningful edge cases**, not just the happy path. Examples include:
  - A student who is enrolled in no courses.
  - A `class_session` that has no grades recorded yet.
  - Invalid or missing attributes that should trigger validation failures.
