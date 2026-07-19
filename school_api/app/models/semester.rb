class Semester < ApplicationRecord
  has_many :class_sessions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
