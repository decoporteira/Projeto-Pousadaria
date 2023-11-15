class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :inn
  enum role: [:admin, :owner, :guest ]
  
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
