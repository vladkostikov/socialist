class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :comments
  has_one :wall, as: :wallable

  validates :username, presence: true, uniqueness: true

  after_create do
    self.create_wall
  end
end
