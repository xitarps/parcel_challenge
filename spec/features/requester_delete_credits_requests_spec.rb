require 'rails_helper'

feature 'Requester delete credit requests' do
  scenario 'successfully' do
    log_in_requester
    generate_credits_and_parcels('100000', 12)
    @credit.already_accepted = false
    @credit.save
    visit requester_dashboard_path
    click_on 'Delete'

    expect(page).to have_content(I18n.t(:credit_destroyed).capitalize)
  end

  scenario 'fail when accepted' do
    log_in_requester
    generate_credits_and_parcels('100000', 12)
    visit requester_dashboard_path
    click_on 'Delete'

    expect(page).to have_content(I18n.t(:error_on_delete).capitalize)
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
