require 'rails_helper'

describe Article, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :text }
  end

  describe 'associations' do
    it { should have_many :comments }
  end

  describe '#subject' do
    it 'returns the article title' do
      # Создаём article с указанным title
      article = create(:article, title: 'Good title')

      expect(article.subject).to eq 'Good title'
    end
  end

  describe '#last_comment' do
    it 'returns last comment' do
      # Создаём публикацию с комментариями
      article = create(:article_with_comments)

      expect(article.last_comment.body).to eq 'Comment body 3'
    end
  end
end
