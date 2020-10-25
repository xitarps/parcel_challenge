require 'rails_helper'

feature 'Admin accept credit request' do
  scenario 'successfully' do
    log_in_admin
    generate_requester
    generate_credits_and_parcels(12, '100000')
    @credit.already_accepted = false
    @credit.save
    visit credit_path(@credit)
    click_on 'Accept'

    expect(page).to have_content('Parcels generated successfully')
  end

  scenario 'fail when already accepted' do
    log_in_admin
    generate_requester
    generate_credits_and_parcels(12, '100000')
    @credit.already_accepted = true
    @credit.save
    visit credit_path(@credit)
    click_on 'Accept'
    
    expect(page).to have_content('Parcels generation error(probably already accepted)')
  end
end

def log_in_admin
  @admin = FactoryBot.create(:admin)
  login_as @admin, scope: :admin
end

def generate_requester
  @requester = FactoryBot.create(:requester)
end

def generate_credits_and_parcels(periods, loan)
  @credit = FactoryBot.build(:credit, parcel: '0.0', tax: '1.5',
    periods: periods, already_accepted: false,
    loan: loan, requester: @requester)
  
  @credit.save

  @credit.already_accepted = false

  @credit.send(:generate_pmt)
end
