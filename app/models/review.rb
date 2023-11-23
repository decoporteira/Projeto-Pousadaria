class Review < ApplicationRecord
  belongs_to :reservation
  has_one :guest, through: :reservation
  validates :rating, :comment, presence: true
end
