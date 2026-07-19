class Course < ApplicationRecord
  belongs_to :department
  has_many :class_sessions, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
