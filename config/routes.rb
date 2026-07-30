Rails.application.routes.draw do
  # Student-facing routes
  scope "/students/:id" do
    get "/",       to: "students#show",   as: :student
    get "/courses", to: "students#courses", as: :student_courses
  end
end
