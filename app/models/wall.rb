class Wall < ApplicationRecord
  belongs_to :wallable, polymorphic: true
  has_many :articles
end
