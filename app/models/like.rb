class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :likeable }
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true
end
