# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :upload

  scope :filter_by_upload, ->(upload_id) { where(upload_id: upload_id) if upload_id }
end
