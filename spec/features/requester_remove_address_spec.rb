require 'rails_helper'

feature 'Requester remove address number' do
  scenario 'successfully' do
    log_in_requester
    
    visit root_path
    click_on 'Edit account'
    click_on '+ Addresses'
    click_on 'Add Address'
    fill_in "Cep",	with: "01001000" 
    fill_in 'Number',	with: '111'
    click_on 'Save'
    click_on 'Addresses'

    click_on 'Delete'

    expect(page).to have_content('Address number removed')
  end

  scenario 'fail - blank', js: false do
    log_in_requester
    
    visit root_path
    click_on 'Edit account'
    click_on '+ Addresses'
    click_on 'Add Address'
    fill_in "Cep",	with: "01001000" 
    fill_in 'Number',	with: '111'
    click_on 'Save'
    click_on 'Addresses'

    Address.find(1).destroy
    click_on 'Delete'

    expect(page).to have_content('Error on Address remove')
  end
end

def log_in_requester
  @requester = FactoryBot.create(:requester)
  login_as @requester, scope: :requester
end