class Upload < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :cafe_smoking
  belongs_to :cafe_charging
  belongs_to :cafe_wifi
end
