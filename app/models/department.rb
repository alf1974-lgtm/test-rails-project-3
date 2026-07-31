class Department < ApplicationRecord
  has_many :courses, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  def to_s
    name
  end
end
