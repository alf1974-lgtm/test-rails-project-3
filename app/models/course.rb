class Course < ApplicationRecord
  belongs_to :department
  has_many :class_sessions, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :credits, presence: true, numericality: { greater_than: 0 }

  def to_s
    "#{code}: #{name}"
  end
end
