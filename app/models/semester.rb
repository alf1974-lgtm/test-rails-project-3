class Semester < ApplicationRecord
  validates :name,       presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date,   presence: true
  validate  :end_after_start

  has_many :class_sessions, dependent: :destroy

  private

  def end_after_start
    return unless start_date && end_date
    errors.add(:end_date, "must be after start date") if end_date <= start_date
  end
end
