FactoryBot.define do
  factory :requester do
    email { 'user@test.com' }
    password { '123456' }
    cnpj { '06510631000137' }
    company_name { 'Test co' }
  end
end
