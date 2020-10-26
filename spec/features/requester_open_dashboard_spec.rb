require 'rails_helper'

feature 'Requester open dashboard' do
  scenario 'successfully if logged in' do
    log_in_requester
    visit requester_dashboard_path

    expect(page).to have_content('user@test.com')
  end
  scenario 'fail when not logged' do
    visit requester_dashboard_path

    expect(page).not_to have_content('user@test.com')
    expect(page).to have_content(I18n.t(:log_in).capitalize)
  end
end

def log_in_requester
  @requester = FactoryBot.create(:requester)
  login_as @requester, scope: :requester
end
