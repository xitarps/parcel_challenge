require 'rails_helper'

feature 'Requester add phone number' do
  scenario 'successfully' do
    log_in_requester
    
    visit root_path
    click_on 'Edit account'
    click_on '+ Phone numbers'
    click_on 'Add Phone'

    fill_in 'Number',	with: '11900000000'
    click_on 'Save'

    expect(page).to have_content('Phone added')
  end

  scenario 'fail - blank' do
    log_in_requester
    
    visit root_path
    click_on 'Edit account'
    click_on '+ Phone numbers'
    click_on 'Add Phone'

    fill_in 'Number',	with: ''
    click_on 'Save'

    expect(page).not_to have_content('Phone added')
  end
end

def log_in_requester
  @requester = FactoryBot.create(:requester)
  login_as @requester, scope: :requester
end