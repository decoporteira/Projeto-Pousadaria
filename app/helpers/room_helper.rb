module RoomHelper
    def current_price(room)
        current_price = room.daily_rate
        room.prices.each do |price|
        dates = Price.where(start_date: price.start_date..price.final_date, room_id: room.id)
        dates.each do |date|
            new_range = Range.new(date.start_date, date.final_date)
            if new_range && new_range.include?(Date.today)
            return current_price = date.new_rate
            end
        end
        end
        current_price
    end
end