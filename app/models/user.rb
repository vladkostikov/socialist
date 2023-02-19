class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :comments
  has_many :likes
  has_one :wall, as: :wallable
  has_one_attached :avatar

  validates :username, uniqueness: true, format: { with: /\A[a-zA-Z]*\z/},
            length: { maximum: 32 }
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
end
