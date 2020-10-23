FactoryBot.define do
  factory :credit do
    parcel { '88.34' }
    tax { '0.25' }
    periods { 12 }
    already_accepted { false }
    loan { '1000.01' }
    association :requester, factory: :requester
  end
end
