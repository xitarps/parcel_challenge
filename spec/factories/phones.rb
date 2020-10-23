FactoryBot.define do
  factory :phone do
    number { '11012345678' }
    association :requester, factory: :requester
  end
end
