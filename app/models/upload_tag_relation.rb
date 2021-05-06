class UploadTagRelation < ApplicationRecord
  belongs_to :tag
  belongs_to :upload
end
