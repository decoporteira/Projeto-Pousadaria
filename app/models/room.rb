class Room < ApplicationRecord
    belongs_to :inn
    has_many :prices, dependent: :destroy
    has_many :reservations

    enum balcony: [:possui, :'não possui']
    enum available: [:sim, :não]
    enum air_conditioner: [:'possui ar condicionado', :'não possui ar condicionado']
    enum tv: [:'possui tv', :'não possui tv']
    enum wardrobe: [:'possui guarda-roupas', :'não possui guarda-roupas']
    enum safe: [:'possui cofre', :'não possui cofre']
    enum accessible: [:'quarto com acessibilidade', :'quarto sem acessibilidade']
    
    validates :name, :description, :guest, :size, :daily_rate, :balcony, :air_conditioner, :tv, :wardrobe, :safe, :accessible, :available,  presence: true
    
end