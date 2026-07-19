class Course < ApplicationRecord
  validates :name, presence: true

  belongs_to :department
  has_many :class_sessions, dependent: :destroy
end
