require 'rails_helper'

feature 'Requester generate credit requests' do
  scenario 'successfully' do
    log_in_requester
    visit new_credit_path
    fill_in "tax",	with: "1.5"
    fill_in "periods",	with: "12" 
    fill_in "loan",	with: "100000" 
    click_on 'Save'

    expect(page).to have_content("R$ 100000")
    expect(page).to have_content('12')
    expect(page).to have_content("R$ 9167.999")
  end

  scenario 'fail' do
    log_in_requester
    visit new_credit_path
    fill_in "tax",	with: "1.5"
    fill_in "periods",	with: "" 
    fill_in "loan",	with: ""
    click_on 'Save'

    expect(page).not_to have_content("R$ 100000")
    expect(page).not_to have_content('12')
    expect(page).not_to have_content("R$ 9167.999")
    expect(page).to have_content(I18n.t(:error))
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
