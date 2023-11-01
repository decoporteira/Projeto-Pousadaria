class Price < ApplicationRecord
  belongs_to :room

  validate :validate_date

  def validate_date

     if Price.where(start_date: start_date..final_date).count > 0
       errors.add(:time, " - Essa data já está reservada para outro preço")
     end
  end
end
