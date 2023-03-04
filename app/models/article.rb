class Article < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  belongs_to :user
  belongs_to :wall
  has_rich_text :content
  validates :content, presence: true

  def subject
    title
  end

  def last_comment
    comments.last
  end
end
