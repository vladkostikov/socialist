FactoryBot.define do
  factory :article do
    title { 'Article title' }
    text { 'Article text' }

    # Создаём фабрику для создания публикации с несколькими комментариями
    factory :article_with_comments do
      after :create do |article, evaluator|
        # Создаём список из 3-х комментариев
        create_list :comment, 3, article: article
      end
    end
  end
end
