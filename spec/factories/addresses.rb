FactoryBot.define do
  factory :address do
    requester_zip_code { '01001000' }
    state { 'some state' }
    city { 'some city' }
    street { 'some street' }
    number { '123' }
    association :requester, factory: :requester
  end
end
