require 'rails_helper'

feature 'Requester remove phone number' do
  scenario 'successfully' do
    log_in_requester
    
    visit root_path
    click_on 'Edit account'
    click_on '+ Phone numbers'
    click_on 'Add Phone'
    fill_in 'Number',	with: '11900000000'
    click_on 'Save'
    click_on 'Phones'
    click_on 'Delete'

    expect(page).to have_content('Phone number removed')
  end

  scenario 'fail - blank', js: false do
    log_in_requester
    
    visit root_path
    click_on 'Edit account'
    click_on '+ Phone numbers'
    click_on 'Add Phone'
    fill_in 'Number',	with: '11900000000'
    click_on 'Save'
    click_on 'Phones'
    Phone.find(1).destroy
    click_on 'Delete'

    expect(page).to have_content('Error on Phone remove')
  end
end

def log_in_requester
  @requester = FactoryBot.create(:requester)
  login_as @requester, scope: :requester
end