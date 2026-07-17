# test-rails-project-3
test-rails-project again with readme

## Coding Standards

Please follow standard Rails conventions throughout: RESTful routes and controllers, skinny controllers with logic pushed into models or service objects where appropriate, and Rubocop-compliant formatting (2-space indentation, snake_case for methods/variables, CamelCase for classes). Use strong parameters for any writes, and prefer has_many :through associations over manual join handling where applicable. All models and API endpoints must have corresponding RSpec tests (model specs for validations/associations, request specs for the routes), using FactoryBot for test data instead of fixtures. Aim for meaningful coverage of edge cases (e.g., a student with no courses, a class_session with no grades yet) rather than just happy-path tests.
