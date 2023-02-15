class Article < ApplicationRecord
  validates :text, presence: true, length: { maximum: 4000 }
  has_many :comments, as: :commentable
  belongs_to :user
  belongs_to :wall

  def subject
    title
  end

  def last_comment
    comments.last
  end
end
