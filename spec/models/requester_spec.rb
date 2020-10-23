require 'rails_helper'

RSpec.describe Requester, type: :model do
  describe Requester do
    it 'valid when have email, company name, cnpj' do
      @requester = FactoryBot.build(:requester)

      expect(@requester.email).to eq('user@test.com')
      expect(@requester.company_name).to eq('Test co')
      expect(@requester.cnpj).to eq('06510631000137')

      expect(@requester.valid?).to eq(true)
    end

    it 'not valid when email is null' do
      @requester = FactoryBot.build(:requester, email: nil)

      expect(@requester.cnpj).not_to eq('user@test.com')
      expect(@requester.valid?).to eq(false)
    end

    it 'not valid when company name is null' do
      @requester = FactoryBot.build(:requester, company_name: nil)

      expect(@requester.cnpj).not_to eq('Test co')
      expect(@requester.valid?).to eq(false)
    end

    it 'not valid when cnpj is null' do
      @requester = FactoryBot.build(:requester, cnpj: nil)

      expect(@requester.cnpj).not_to eq('06510631000137')
      expect(@requester.valid?).to eq(false)
    end
  end
end
