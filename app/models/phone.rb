class Phone < ApplicationRecord
  belongs_to :requester
  validates :number, presence: true
  validates :requester_id, presence: true
end
