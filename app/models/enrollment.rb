class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :class_session

  validates :user_id, :class_session_id, presence: true
  validates :user_id, uniqueness: { scope: :class_session_id, message: "can only be enrolled once per class session" }
  validate :user_must_be_student

  private

  def user_must_be_student
    if user && !user.student?
      errors.add(:user_id, "must be a student")
    end
  end
end
