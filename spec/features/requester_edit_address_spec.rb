require 'rails_helper'

feature 'Requester edit address number' do
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
    click_on 'Edit'

    fill_in "Cep",	with: "01201000" 
    fill_in 'Number',	with: '111'
    click_on 'Save'


    expect(page).to have_content('Address updated')
    expect(page).to have_content('01201000')
  end

  scenario 'fail - blank' do
    log_in_requester
    
    visit root_path
    click_on 'Edit account'
    click_on '+ Addresses'
    click_on 'Add Address'

    fill_in "Cep",	with: "01001000" 
    fill_in 'Number',	with: '111'
    click_on 'Save'

    click_on 'Addresses'
    click_on 'Edit'

    fill_in "Cep",	with: "" 
    fill_in 'Number',	with: ''
    click_on 'Save'


    expect(page).not_to have_content('Address updated')
    expect(page).to have_content('Error on Address save')
  end
end

def log_in_requester
  @requester = FactoryBot.create(:requester)
  login_as @requester, scope: :requester
end