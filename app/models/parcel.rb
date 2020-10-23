class Parcel < ApplicationRecord
  belongs_to :credit

  validates :position, presence: true
  validates :value, presence: true
  validates :expiring_date, presence: true
  validates :paid, inclusion: [true, false]
end
