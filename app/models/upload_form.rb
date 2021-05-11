class UploadForm
  include ActiveModel::Model
  attr_accessor :title, :text, :url, :working_day, :day_off, :cafe_wifi_id, :cafe_charging_id, :cafe_smoking_id,
                :user_id, :image, :name, :address, :latitude, :longitude, :upload_id

  with_options presence: true do
    validates :title
    validates :text
    validates :cafe_wifi_id
    validates :cafe_charging_id
    validates :cafe_smoking_id
    validates :user_id
    validates :image
    validates :name
    validates :address
    validates :latitude
    validates :longitude
    validates :upload_id
  end

  with_options numericality: { other_than: 0 } do
    validates :cafe_wifi_id
    validates :cafe_charging_id
    validates :cafe_smoking_id
  end

  def save
    upload = Upload.create(title: title, text: text, url: url, working_day: working_day, day_off: day_off, cafe_wifi_id: cafe_wifi_id, cafe_charging_id: cafe_charging_id, cafe_smoking_id: cafe_smoking_id, user_id: user_id, image: image)
    tag = Tag.create(name: name)
    map = Map.create(address: address, latitude: latitude, longitude: longitude, upload_id: upload_id)

    UploadTagRelation.create(upload_id: upload.id, tag_id: tag.id)
  end
end