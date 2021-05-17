class UploadTagRelation < ApplicationRecord
  belongs_to :tag
  belongs_to :upload

  validate :upload_id
  validate :tag_id
end
