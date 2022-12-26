require 'rails_helper'

feature 'Contact Creation' do
  scenario 'Allows access to contacts page' do
    visit '/contacts'
    expect(page).to have_content 'Контакты'
  end
end
