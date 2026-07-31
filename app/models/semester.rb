class Semester < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :class_sessions, dependent: :destroy
end
