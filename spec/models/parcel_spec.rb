require 'rails_helper'

RSpec.describe Parcel, type: :model do
  describe Parcel do
    before(:each) do
      generate_requester
      generate_credit
      approve_credit
    end
    it 'valid when have position, value, expiring_date, paid' do
      @parcel = FactoryBot.build(:parcel)

      expect(@parcel.position).to eq(1)
      expect(@parcel.valid?).to eq(true)
    end
    it 'valid when credit is already approved' do
      @credit.already_accepted = true
      @credit.send(:generate_parcels)

      expect(@credit.parcels.empty?).to eq(false)
    end
    it 'not valid when credit is not approved yet' do
      @credit.already_accepted = false
      @credit.send(:generate_parcels)

      expect(@credit.parcels.empty?).to eq(true)
    end
    it 'not valid when position is null' do
      @parcel = FactoryBot.build(:parcel, position: nil)

      expect(@parcel.position).not_to eq(1)
      expect(@parcel.valid?).to eq(false)
    end
    it 'not valid when value is null' do
      @parcel = FactoryBot.build(:parcel, value: nil)

      expect(@parcel.value).not_to eq('9.99')
      expect(@parcel.valid?).to eq(false)
    end
    it 'not valid when expiring_date is null' do
      @parcel = FactoryBot.build(:parcel, expiring_date: nil)

      expect(@parcel.expiring_date).not_to eq('2020-10-23')
      expect(@parcel.valid?).to eq(false)
    end
    it 'not valid when paid is null' do
      @parcel = FactoryBot.build(:parcel, paid: nil)

      expect(@parcel.paid).not_to eq('false')
      expect(@parcel.valid?).to eq(false)
    end

    it 'should create right amount of parcels' do
      @credit.already_accepted = true
      @credit.update(periods: 15)
      @credit.send(:generate_parcels)

      expect(@credit.parcels.count).to eq(15)
      expect(@credit.parcels.count).not_to eq(12)
    end
  end
end

def generate_requester
  @requester = FactoryBot.create(:requester)
end

def generate_credit
  @credit = FactoryBot.build(:credit, requester: @requester)
  @credit.save
end

def approve_credit
  @credit.already_accepted = true
end
