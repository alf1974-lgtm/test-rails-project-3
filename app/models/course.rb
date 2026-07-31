class Course < ApplicationRecord
  validates :name,    presence: true
  validates :code,    presence: true, uniqueness: true
  validates :credits, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :department
  has_many   :class_sessions, dependent: :destroy
end
