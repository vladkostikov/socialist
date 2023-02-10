class Comment < ApplicationRecord
  validates :author, presence: true
  validates :body, presence: true, length: { maximum: 4000 }
  belongs_to :commentable, polymorphic: true
end
