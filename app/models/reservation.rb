class Reservation < ApplicationRecord
  belongs_to :room

  validate :validate_dates

  def validate_dates
    current_range = (self.start_date..self.final_date)
     ranges = Price.where(room_id: self.room_id)
    ranges.each do |range|
     new_range = range.start_date..range.final_date
      if (current_range.overlaps?new_range) && (self.id != range.id)
        return errors.add(:start_date, " - Essa data já está em uso.")
      end
    end
  end

    def get_price(range)
      # p @room
      # p range
      # total_price = 0
      # season_days = 0
      # range.each do |day|
      #     @room.prices.each do |price|
      #         if day.between?(price.start_date, price.final_date) == true
      #             total_price = total_price + price.new_rate
      #             season_days += 1
      #         end
      #     end
      # end
      # total_regular_price = range.count - season_days
      # total_price = total_price + (total_regular_price * @room.daily_rate)
      # @total_price = total_price

  end
end
