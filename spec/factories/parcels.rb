FactoryBot.define do
  factory :parcel do
    position { 1 }
    value { '9.99' }
    expiring_date { '2020-10-23' }
    paid { false }
    association :credit, factory: :credit
  end
end
