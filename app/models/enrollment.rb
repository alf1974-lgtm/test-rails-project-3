class Enrollment < ApplicationRecord
  belongs_to :class_session
  belongs_to :student, class_name: "User"

  validates :grade, inclusion: { in: %w[A B C D F], allow_blank: true }
end
