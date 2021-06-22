# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :upload

  validates :user_id, presence: true
  validates :upload_id, presence: true

  scope :filter_by_upload, ->(upload_id) { where(upload_id: upload_id) if upload_id }
end
