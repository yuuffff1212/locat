class Tag < ApplicationRecord
  has_many :upload_tag_relations
  has_many :uploads, through: :upload_tag_relations

  validates :name, uniqueness: true

end
