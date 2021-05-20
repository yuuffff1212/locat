class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :uploads
  has_one_attached :avatar
  with_options presence: true do
    validates :email
    validates :password, format: {with:/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "is invalid. Include both letters and numbers. Input half-width characters." }
    validates :name
    validates :profile, length: { maximum: 300}
    validates :avatar
  end
end
