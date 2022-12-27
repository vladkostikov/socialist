require 'rails_helper'
require_relative '../support/session_helper'

feature 'Article creation' do
  before(:each) do
    sign_up
  end

  scenario 'Allows user to visit new article page' do
    visit new_article_path
    expect(page).to have_content 'Добавить публикацию'
  end

  scenario 'Allows user to create new article' do
    visit new_article_path

    fill_in :article_title, with: 'Title'
    fill_in :article_text, with: 'Text'

    click_button 'Добавить публикацию'

    expect(page).to have_content 'назад к публикациям'
  end
end
