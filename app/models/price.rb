class Price < ApplicationRecord
  belongs_to :room

  validate :validate_date

  def validate_date
    current_range = (self.start_date..self.final_date)
    ranges = Price.where(room_id: self.room_id)
    ranges.each do |range|
      new_range = range.start_date..range.final_date
      if (current_range.overlaps?new_range) && (self.id != range.id)
        return errors.add(:start_date, " - Essa data já está em uso.")
      end
    end
  end
end