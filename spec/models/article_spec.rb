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
      article = create(:article, title: 'Good title')

      expect(article.subject).to eq 'Good title'
    end
  end
end
