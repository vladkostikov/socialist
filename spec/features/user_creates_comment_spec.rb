require 'rails_helper'
require_relative '../support/session_helper'
require_relative '../support/article_helper'

feature 'Article creation' do
  before(:each) do
    sign_up
  end

  scenario 'Allows user to visit article page' do
    create_article
    expect(page).to have_content 'Комментарии:'
  end

  scenario 'Allows user to create new comment' do
    create_article

    fill_in :comment_body, with: 'New comment'
    click_button 'Добавить комментарий'

    expect(page).to have_content "\nNew comment\n"
  end
end
