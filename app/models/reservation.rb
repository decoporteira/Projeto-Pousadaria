class Reservation < ApplicationRecord
  belongs_to :room
  validates :guest_number, presence: true
  validates :start_date, presence: true
  validates :final_date, presence: true
  validates :guest_number, :final_date, :start_date, presence: true, on: :check
  validate :validate_dates

  def validate_dates
    current_range = (self.start_date..self.final_date)
    ranges = Reservation.where(room_id: self.room_id)
    ranges.each do |range|
     
     new_range = range.start_date..range.final_date
      if (current_range.overlaps?new_range) && (self.id != range.id)
        return errors.add(:start_date, " - Essa data já está em uso.")
      end
    end
  end
end
