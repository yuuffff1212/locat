class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :uploads, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_uploads, through: :favorites, source: :upload
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :follower, through: :passive_relationships, source: :follower
  has_one_attached :avatar
  with_options presence: true do
    validates :email
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "is invalid. Include both letters and numbers. Input half-width characters." }, allow_blank: true
    validates :name
    validates :profile, length: { maximum: 300 }
    validates :avatar
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
