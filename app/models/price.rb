class Price < ApplicationRecord
  belongs_to :room

  # validate :validate_date

  # def validate_date

  #   Price.where("start_date >= ? AND start_date <= ?", start_date, final_date).count

  #    start_date.to_s
  #   range = (start_date)..(final_date)
  #   # if date < Date.today
  #   #   errors.add(:date, "Não pode fazer reserva para datas passadas")
  #   # end

  #   #  Scheduler.where(start_date: start_date..end_date)
  #   Price.where('start_date BETWEEN ? AND ?',start_date, final_date).count
    
  #   range.each do |date|
      
  #     p Price.where(start_date: date.to_s).count > 0
     
  #     #if Price.where(start_date: date)
     
  #     #   p "erro"
  #     #    return errors.add(:time, " - Essa data já está reservada para outro preço")
  #     #end

  #   end
     
  #   # end
  #     #    start_date.between?(start_date, final_date)
    
  #     #  final_date
  #     #  #Date.yesterday.between?(Date.yesterday, Date.tomorrow)
  #     #  Price.where(:start_date => start_date..final_date)
  #     #  Price.where("start_date BETWEEN ? AND ?", start_date, final_date)
  #     #  if Price.where(start_date: start_date..final_date).count > 0
  #     #    errors.add(:time, " - Essa data já está reservada para outro preço")
  #     #  end
  # end
end
