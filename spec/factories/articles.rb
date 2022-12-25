FactoryBot.define do
  factory :user do
    email { 'email@email.com' }
    password { 'password' }
  end

  factory :article do
    title { 'Article title' }
    text { 'Article text' }
    association :user

    # Создаём фабрику для создания публикации с несколькими комментариями
    factory :article_with_comments do
      after :create do |article, evaluator|
        # Создаём список из 3-х комментариев
        create_list :comment, 3, article: article
      end
    end
  end
end
