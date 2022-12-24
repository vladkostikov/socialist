FactoryBot.define do
  factory :comment do
    author { 'Comment author' }
    sequence(:body) { |n| "Comment body #{n}"}
  end
end
