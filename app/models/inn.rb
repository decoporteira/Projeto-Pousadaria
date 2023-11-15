class Inn < ApplicationRecord
  belongs_to :owner
  has_many :rooms, dependent: :destroy

  enum pet: [:permitidos, :'não permitidos']
  enum status: [:ativa, :desativada]
  
  validates :trade_name, :company_name, :registration_number, :phone, :email, :address, :neighborhood, 
            :city, :zip_code, :description, :payment_methods, :pet, :rules, :check_in, :check_out, :status,  presence: true
  validates :registration_number, uniqueness: true

  validates :owner_id, uniqueness: { message: "Você só pode ter uma pousada cadastrada." }

end
