class Map < ApplicationRecord
  belongs_to :upload

  geocoded_by :address
  after_validation :geocode
end
