require 'rails_helper'

feature 'Requester add address number' do
  scenario 'successfully' do
    log_in_requester
    
    visit root_path
    click_on 'Edit account'
    click_on '+ Addresses'
    click_on 'Add Address'

    fill_in "Cep",	with: "01001000" 
    fill_in 'Number',	with: '111'
    click_on 'Save'

    expect(page).to have_content('Address added')
  end

  scenario 'fail - blank' do
    log_in_requester
    
    visit root_path
    click_on 'Edit account'
    click_on '+ Addresses'
    click_on 'Add Address'

    fill_in "Cep",	with: "" 
    fill_in 'Number',	with: ''
    click_on 'Save'

    expect(page).not_to have_content('Address added')
    expect(page).to have_content('Error on Address save')
  end
end

def log_in_requester
  @requester = FactoryBot.create(:requester)
  login_as @requester, scope: :requester
end