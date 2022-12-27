require 'rails_helper'
require_relative '../support/session_helper'
require_relative '../support/article_helper'

feature 'Article creation' do
  before(:each) do
    sign_up
    create_article
    edit_path = current_path + '/edit'
    visit edit_path
  end

  scenario 'Allows user to edit article page' do
    expect(page).to have_content 'Редактирование публикации'
  end

  scenario 'Allows user to edit article title' do
    fill_in :article_title, with: 'New title'
    click_button 'Сохранить'

    expect(page).to have_content "\nNew title\n"
  end

  scenario 'Allows user to edit article text' do
    fill_in :article_text, with: 'New article text'
    click_button 'Сохранить'

    expect(page).to have_content "\nNew article text\n"
  end
end
