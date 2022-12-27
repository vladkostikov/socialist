def create_article
  visit new_article_path

  fill_in :article_title, with: 'Title'
  fill_in :article_text, with: 'Text'

  click_button 'Добавить публикацию'
end
