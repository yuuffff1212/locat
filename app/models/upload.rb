class Upload < ApplicationRecord
  has_one_attached :image
  has_one :map
  belongs_to :user
  has_many :upload_tag_relations, dependent: :destroy
  has_many :tags, through: :upload_tag_relations
  has_many :favorites, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :cafe_smoking
  belongs_to :cafe_charging
  belongs_to :cafe_wifi
end
