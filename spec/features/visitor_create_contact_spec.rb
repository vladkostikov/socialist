require 'rails_helper'

feature 'Contact Creation' do
  scenario 'Allows access to contacts page' do
    visit '/contacts'
    expect(page).to have_content I18n.t("contacts.contact_header")
  end

  scenario 'Allows a guest to create contact' do
    visit '/contacts'

    fill_in :contact_email, with: 'user@example.com'
    fill_in :contact_message, with: 'Message'

    click_button 'Save Contact'

    expect(page).to have_content 'Спасибо'
  end
end
