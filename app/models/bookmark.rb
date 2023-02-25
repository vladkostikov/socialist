class Bookmark < ApplicationRecord
  validates :user_id, uniqueness: { scope: :bookmarkable }
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true
end
