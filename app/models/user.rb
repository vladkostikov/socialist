class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :comments
  has_many :likes
  has_many :own_bookmarks, class_name: 'Bookmark'
  has_many :bookmarks, as: :bookmarkable
  has_one :wall, as: :wallable
  has_one_attached :avatar

  has_many :followed_users,
           foreign_key: :follower_id,
           class_name: 'Relationship',
           dependent: :destroy

  has_many :followees,
           through: :followed_users,
           dependent: :destroy

  has_many :following_users,
           foreign_key: :followee_id,
           class_name: 'Relationship',
           dependent: :destroy

  has_many :followers,
           through: :following_users,
           dependent: :destroy

  validates :username, uniqueness: true, format: { with: /\A[a-zA-Z]*\z/},
            length: { maximum: 32 }, allow_blank: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :avatar, content_type: ['image/png', 'image/jpeg'],
            size: {less_than: 1.megabyte}

  after_create do
    self.create_wall
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["email", "first_name", "last_name", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["avatar_attachment", "avatar_blob"]
  end
end
