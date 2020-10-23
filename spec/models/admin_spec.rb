require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe Admin do
    it 'valid when have email' do
      @admin = FactoryBot.build(:admin)

      expect(@admin.email).to eq('admin@test.com')
      expect(@admin.valid?).to eq(true)
    end

    it 'not valid when email is null' do
      @admin = FactoryBot.build(:admin, email: nil)

      expect(@admin.email).not_to eq('admin@test.com')
      expect(@admin.valid?).to eq(false)
    end
  end
end
