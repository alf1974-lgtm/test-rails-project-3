class Semester < ApplicationRecord
  has_many :class_sessions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :term, presence: true, inclusion: { in: %w[Fall Spring Summer Winter] }
  validates :year, presence: true, numericality: { only_integer: true }
end
