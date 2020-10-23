class Requester < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :nullify
  has_many :phones, dependent: :nullify
  has_many :credits, dependent: :nullify

  validates :cnpj, presence: true
  validates :company_name, presence: true
end
