require 'rails_helper'

RSpec.describe Credit, type: :model do
  describe Credit do
    before(:each) do
      generate_requester
    end
    it 'valid when have parcel, tax, periods, already_accepted, loan' do
      @credit = FactoryBot.build(:credit)
      @credit.requester = @requester

      expect(@credit.parcel.to_s).to eq('88.34')
      expect(@credit.tax.to_s).to eq('0.25')
      expect(@credit.periods).to eq(12)
      expect(@credit.already_accepted).to eq(false)
      expect(@credit.loan.to_s).to eq('1000.01')
      expect(@credit.valid?).to eq(true)
    end
    it 'not valid when parcel is null' do
      @credit = FactoryBot.build(:credit, parcel: nil)
      @credit.requester = @requester

      expect(@credit.parcel.to_s).not_to eq('88.34')
      expect(@credit.valid?).to eq(false)
    end
    it 'not valid when tax is null' do
      @credit = FactoryBot.build(:credit, tax: nil)
      @credit.requester = @requester

      expect(@credit.tax.to_s).not_to eq('0.25')
      expect(@credit.valid?).to eq(false)
    end
    it 'not valid when periods is null' do
      @credit = FactoryBot.build(:credit, periods: nil)
      @credit.requester = @requester

      expect(@credit.periods).not_to eq(12)
      expect(@credit.valid?).to eq(false)
    end
    it 'not valid when already_accepted is null' do
      @credit = FactoryBot.build(:credit, already_accepted: nil)
      @credit.requester = @requester

      expect(@credit.already_accepted).not_to eq(false)
      expect(@credit.valid?).to eq(false)
    end
    it 'not valid when loan is null' do
      @credit = FactoryBot.build(:credit, loan: nil)
      @credit.requester = @requester

      expect(@credit.loan.to_s).not_to eq('1000.01')
      expect(@credit.valid?).to eq(false)
    end

    it 'should generate correct parcel value' do
      # https://www.matematica.pt/util/calculadora-cientifica.php
      @credit = FactoryBot.build(:credit, parcel: '0.0', tax: '1.5',
                                          periods: 12, already_accepted: true,
                                          loan: '100000')
      @credit.requester = @requester

      @credit.send(:generate_pmt)

      # expect(@credit.parcel.to_s).to eq('9167.999290622945')
      expect(@credit.parcel.to_s).to eq('9167.999290622894')
      expect(@credit.valid?).to eq(true)
    end
  end
end

def generate_requester
  @requester = FactoryBot.create(:requester)
end
