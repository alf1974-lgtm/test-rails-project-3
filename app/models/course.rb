class Course < ApplicationRecord
  validates :name,        presence: true
  validates :code,        presence: true, uniqueness: true
  validates :department,  presence: true

  belongs_to :department
  has_many   :class_sessions, dependent: :destroy
end
