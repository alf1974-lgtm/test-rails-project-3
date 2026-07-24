class Course < ApplicationRecord
  belongs_to :department
  has_many :class_sessions, dependent: :destroy

  validates :name, :code, presence: true
  validates :code, uniqueness: true
end
