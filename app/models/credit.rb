class Credit < ApplicationRecord
  belongs_to :requester
  has_many :parcels, dependent: :nullify

  validates :parcel, presence: true
  validates :tax, presence: true
  validates :periods, presence: true
  validates :already_accepted, inclusion: [true, false]
  validates :loan, presence: true

  private

  def generate_parcels
    periods.times do |index|
      parcels.create(position: index + 1,
                     value: parcel,
                     expiring_date: if index.zero?
                                      30.days.from_now
                                    else
                                      parcels.find_by(position: index)
                                            .expiring_date + 30
                                    end) if already_accepted
    end
  end
end
