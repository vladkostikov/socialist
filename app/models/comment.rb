class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 4000 }
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :bookmarks, as: :bookmarkable

  def self.comments_find(commentable_type, commentable_id)
    Comment.where('commentable_type = ? and commentable_id = ? and parent_id = 0',
                  commentable_type, commentable_id).order('id ASC')
  end

  def self.replies_find(commentable_type, commentable_id)
    Comment.where('commentable_type = ? and commentable_id = ? and parent_id != 0',
                  commentable_type, commentable_id).order('id ASC')
           .group_by { |comment| comment['parent_id'] }
  end
end
