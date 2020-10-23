require 'rails_helper'

RSpec.describe Address, type: :model do
  describe Address do
    before(:each) do
      generate_requester
    end

    it 'valid when have requester_zip_code state city street number' do
      @address = FactoryBot.build(:address)
      @address.requester = @requester

      expect(@address.requester_zip_code).to eq('01001000')
      expect(@address.state).to eq('some state')
      expect(@address.city).to eq('some city')
      expect(@address.street).to eq('some street')
      expect(@address.number).to eq('123')
      expect(@address.valid?).to eq(true)
    end
    it 'not valid when requester_zip_code is null' do
      @address = FactoryBot.build(:address, requester_zip_code: nil)
      @address.requester = @requester

      expect(@address.requester_zip_code).not_to eq('01001000')
      expect(@address.valid?).to eq(false)
    end
    it 'not valid when state is null' do
      @address = FactoryBot.build(:address, state: nil)
      @address.requester = @requester

      expect(@address.state).not_to eq('some state')
      expect(@address.valid?).to eq(false)
    end
    it 'not valid when city is null' do
      @address = FactoryBot.build(:address, city: nil)
      @address.requester = @requester

      expect(@address.city).not_to eq('some city')
      expect(@address.valid?).to eq(false)
    end
    it 'not valid when street is null' do
      @address = FactoryBot.build(:address, street: nil)
      @address.requester = @requester

      expect(@address.street).not_to eq('some street')
      expect(@address.valid?).to eq(false)
    end
    it 'not valid number street is null' do
      @address = FactoryBot.build(:address, number: nil)
      @address.requester = @requester

      expect(@address.number).not_to eq('123')
      expect(@address.valid?).to eq(false)
    end
  end
end

def generate_user
  @requester = FactoryBot.create(:requester)
end
