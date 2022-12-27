require 'rails_helper'
require_relative '../support/session_helper'
require_relative '../support/article_helper'

feature 'Article creation' do
  before(:each) do
    sign_up
  end

  scenario 'Allows user to visit new article page' do
    visit new_article_path
    expect(page).to have_content 'Добавить публикацию'
  end

  scenario 'Allows user to create new article' do
    create_article

    expect(page).to have_content 'назад к публикациям'
  end
end
