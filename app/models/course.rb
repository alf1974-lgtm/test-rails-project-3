class Course < ApplicationRecord
  belongs_to :department

  has_many :class_sessions, dependent: :destroy

  CODE_FORMAT = /\A[A-Z]{2,4}\d{3,4}\z/

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true,
                   format: { with: CODE_FORMAT, message: 'must be 2-4 uppercase letters followed by 3-4 digits' }
end
