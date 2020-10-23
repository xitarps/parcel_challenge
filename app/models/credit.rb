class Credit < ApplicationRecord
  belongs_to :requester

  validates :parcel, presence: true
  validates :tax, presence: true
  validates :periods, presence: true
  validates :already_accepted, inclusion: [true, false]
  validates :loan, presence: true
end
