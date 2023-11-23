class Review < ApplicationRecord
  belongs_to :reservation
  has_one :guest, through: :reservation
end
