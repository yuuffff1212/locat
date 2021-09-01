class Upload < ApplicationRecord
  has_one_attached :image
  has_one :map
  belongs_to :user
  has_many :upload_tag_relations, dependent: :destroy
  has_many :tags, through: :upload_tag_relations
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :cafe_smoking
  belongs_to :cafe_charging
  belongs_to :cafe_wifi

  def self.create_ranks
    Upload.find(Favorite.group(:upload_id).order('count(upload_id) DESC').limit(4).pluck(:upload_id))
  end

  def self.search(search)
    if search != ''
      Upload.where(['title LIKE(?) OR text LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      Upload.all
    end
  end
end
