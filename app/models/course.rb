class Course < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  belongs_to :department
  has_many :class_sessions, dependent: :destroy
end
