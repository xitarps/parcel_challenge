require 'rails_helper'

feature 'Requester view parcels' do
  scenario 'successfully' do
    log_in_requester
    generate_credits_and_parcels(4, '100000')
    @credit.already_accepted = true
    @credit.send(:generate_parcels)
    @credit.save
    visit requester_dashboard_path
    click_on 'details'

    expect(page).to have_content('Nº 1')
    expect(page).to have_content('Nº 2')
    expect(page).to have_content('Nº 3')
    expect(page).to have_content('Nº 4')
  end

  scenario 'fail when not accepted yet' do
    log_in_requester
    generate_credits_and_parcels(4, '100000')
    @credit.already_accepted = false
    @credit.send(:generate_parcels)
    @credit.save
    visit requester_dashboard_path
    click_on 'details'

    expect(page).not_to have_content('Nº 1')
    expect(page).not_to have_content('Nº 2')
    expect(page).not_to have_content('Nº 3')
    expect(page).not_to have_content('Nº 4')
  end
end

def log_in_requester
  @requester = FactoryBot.create(:requester)
  login_as @requester, scope: :requester
end

def generate_credits_and_parcels(periods, loan)
  @credit = FactoryBot.build(:credit, parcel: '0.0', tax: '1.5',
    periods: periods, already_accepted: false,
    loan: loan, requester: @requester)
  
  @credit.save
  
  @credit.send(:generate_pmt)
  @credit.save
end
