class Address < ApplicationRecord
  belongs_to :requester
  validates :requester_zip_code, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :number, presence: true
  validates :requester_id, presence: true
end
