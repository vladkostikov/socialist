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
end
