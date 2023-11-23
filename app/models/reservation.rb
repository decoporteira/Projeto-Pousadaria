class Reservation < ApplicationRecord
  belongs_to :room
  has_one :review
  validates :guest_number, presence: true
  validates :start_date, presence: true
  validates :final_date, presence: true
  validates :guest_number, :final_date, :start_date, presence: true
  validate :number_of_guests, :validate_past_date, :validade_final_date, :validate_dates
  validates :code, presence: true
  validates :code, uniqueness: true
  before_validation :generate_code, on: :create
  enum status: {  canceled: 0, active: 1, 'active stay': 3, ended: 4   }
 

  def number_of_guests
    room = Room.find(self.room_id)
    if self.guest_number > room.guest.to_i
      return errors.add(:guest_number, "Número de hóspede é maior do que o quarto suporta.")
    end

  end
  def validate_past_date
    if self.start_date < Date.today 
      return errors.add(:start_date, "Não pode fazer reserva para datas anteriores ao dia atual.")
    end
  end

  def validade_final_date
    if self.start_date > self.final_date 
      return errors.add(:start_date, "Não pode fazer reserva com data de saída anterior da data de entrada.")
    end
  end

  def validate_dates  
    
    current_range = (self.start_date..self.final_date)
    ranges = Reservation.where(room_id: self.room_id, status: :active)
    ranges.each do |range|
     new_range = range.start_date..range.final_date
      if (current_range.overlaps?new_range) && (self.id != range.id)
        return errors.add(:start_date, " - Essa data já está em uso.")
      end
    end
  end

  def check_value(room)
    range = self.start_date..self.final_date
    total_price = 0
    season_days = 0
    range.each do |day|
        room.prices.each do |price|
            if day.between?(price.start_date, price.final_date) == true
                total_price = total_price + price.new_rate
                season_days += 1
            end
        end
    end
    
    total_regular_price = range.count - season_days
    total_price = total_price + (total_regular_price * room.daily_rate)
    
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
