class Semester < ApplicationRecord
  SEASONS = %w[Fall Spring].freeze

  has_many :class_sessions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :season, presence: true, inclusion: { in: SEASONS }
  validates :year, presence: true, numericality: { only_integer: true, greater_than: 2000 }
  validates :season, uniqueness: { scope: :year, message: 'already exists for this year' }
end
