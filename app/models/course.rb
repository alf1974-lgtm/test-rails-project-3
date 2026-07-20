class Course < ApplicationRecord
  belongs_to :department
  has_many   :class_sessions, dependent: :destroy

  validates :name,        presence: true
  validates :course_code, presence: true, uniqueness: true,
                          format: { with: /\A[A-Z]{2,4}\d{3,4}\z/,
                                    message: "must be like ENG101 or MATH2010" }
  validates :credits,     numericality: { only_integer: true, greater_than: 0 }
end
