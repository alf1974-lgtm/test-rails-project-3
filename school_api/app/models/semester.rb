class Semester < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :season, inclusion: { in: %w[Fall Spring Summer Winter] }
  validates :year, presence: true

  has_many :class_sessions, dependent: :destroy
end
