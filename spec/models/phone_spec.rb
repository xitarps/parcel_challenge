require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe Phone do
    before(:each) do
      generate_requester
    end
    it 'valid when have number' do
      @phone = FactoryBot.build(:phone)
      @phone.requester = @requester

      expect(@phone.number).to eq('11012345678')
      expect(@phone.valid?).to eq(true)
    end
    it 'not valid when number is null' do
      @phone = FactoryBot.build(:phone, number: nil)
      @phone.requester = @requester

      expect(@phone.number).not_to eq('11012345678')
      expect(@phone.valid?).to eq(false)
    end
  end
end

def generate_requester
  @requester = FactoryBot.create(:requester)
end
