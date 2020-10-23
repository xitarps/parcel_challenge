require 'rails_helper'

feature 'Visitor open home page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content(I18n.t(:app_title).capitalize)
    expect(page).to have_content(I18n.t(:welcome_message).capitalize)
  end
end
