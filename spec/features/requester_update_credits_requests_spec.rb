require 'rails_helper'

feature 'Requester update credit requests' do
  scenario 'successfully' do
    log_in_requester
    generate_credits_and_parcels('100000', 12)
    @credit.already_accepted = false
    @credit.save
    visit requester_dashboard_path
    click_on 'Edit'

    fill_in 'tax',	with: '1.5'
    fill_in 'periods',	with: '15' 
    fill_in 'loan',	with: '200000' 

    click_on 'Save'

    expect(page).to have_content('R$ 200000')
    expect(page).to have_content('15')
    expect(page).to have_content('R$ 14988.871')
    expect(page).to have_content(I18n.t(:credit_saved).capitalize)
  end

  scenario 'fail when accepted' do
    log_in_requester
    generate_credits_and_parcels('100000', 12)
    @credit.already_accepted = true
    @credit.save
    visit requester_dashboard_path
    click_on 'Edit'

    fill_in 'tax',	with: '1.5'
    fill_in 'periods',	with: '15' 
    fill_in 'loan',	with: '200000' 

    click_on 'Save'

    expect(page).not_to have_content('R$ 200000')
    expect(page).not_to have_content('15')
    expect(page).not_to have_content('R$ 14988.871')
    expect(page).to have_content(I18n.t(:error).capitalize)
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
