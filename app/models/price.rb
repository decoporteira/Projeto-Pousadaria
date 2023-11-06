class Price < ApplicationRecord
  belongs_to :room

  validate :validate_date

  def validate_date
    prices = Price.where(start_date: start_date..final_date, room_id: self.room_id)
    prices.each do |price|
      p '---------------------'
      p price.id
      p '---------------------'
    end
    if Price.where(start_date: start_date..final_date, room_id: self.room_id).count > 0
      return errors.add(:start_date, " - Essa data já está em uso.")
    end
  end
end
