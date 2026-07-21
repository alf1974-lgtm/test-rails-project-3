class Course < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true,
                   format: { with: /\A[A-Z]{2,4}\d{3}\z/, message: "must be like ENG101" }
  validates :credits, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :department

  has_many :class_sessions, dependent: :destroy
end
