require 'rails_helper'

feature 'Requester view credit requests' do
  scenario 'successfully' do
    log_in_requester
    generate_credits_and_parcels(12,'100000.00')
    generate_credits_and_parcels(15,'200000.00')
    visit requester_dashboard_path

    expect(page).to have_content("R$ 100000")
    expect(page).to have_content('12')
    expect(page).to have_content("R$ 200000")
    expect(page).to have_content('15')
  end
end

def log_in_requester
  @requester = FactoryBot.create(:requester)
  login_as @requester, scope: :requester
end

def generate_credits_and_parcels(periods, loan)
  @credit = FactoryBot.build(:credit, parcel: '0.0', tax: '1.5',
    periods: periods, already_accepted: true,
    loan: loan, requester: @requester)
  
  @credit.save

  @credit.already_accepted = true
  
  @credit.send(:generate_pmt)
end
