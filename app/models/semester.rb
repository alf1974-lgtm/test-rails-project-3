class Semester < ApplicationRecord
  has_many :class_sessions, dependent: :destroy

  TERMS = %w[Fall Spring Summer Winter].freeze

  validates :name, presence: true, uniqueness: true
  validates :term, presence: true, inclusion: { in: TERMS }
  validates :year, presence: true, numericality: { only_integer: true }
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  def to_s
    name
  end

  private

  def end_date_after_start_date
    return unless start_date && end_date

    errors.add(:end_date, "must be after start date") if end_date <= start_date
  end
end
