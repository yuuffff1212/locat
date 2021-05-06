class Upload < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :tags, through: :upload_tag_relations
  has_many :upload_tag_relations
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :cafe_smoking
  belongs_to :cafe_charging
  belongs_to :cafe_wifi
end
