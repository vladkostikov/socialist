require 'rails_helper'
require_relative '../support/session_helper'

feature 'Account creation' do
  scenario 'Allows guest to create account' do
    sign_up
    expect(page).to have_content I18n.t('devise.registrations.signed_up')
  end
end
