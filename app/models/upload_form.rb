class UploadForm
  include ActiveModel::Model
  attr_accessor :title, :text, :url, :working_day, :day_off, :cafe_wifi_id, :cafe_charging_id, :cafe_smoking_id,
                :user_id, :image, :name

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :text, length: { maximum: 1000 }
    validates :cafe_wifi_id
    validates :cafe_charging_id
    validates :cafe_smoking_id
    validates :user_id
    validates :image
    validates :name
  end

  with_options numericality: { other_than: 0 } do
    validates :cafe_wifi_id
    validates :cafe_charging_id
    validates :cafe_smoking_id
  end

  delegate :persisted?, to: :upload

  def initialize(attributes = nil, upload: Upload.new)
    @upload = upload
    attributes ||= default_attributes
    super(attributes)
  end

  def save(tag_list)

    ActiveRecord::Base.transaction do
      @upload.update(title: title, text: text, url: url, working_day: working_day, day_off: day_off, cafe_wifi_id: cafe_wifi_id, cafe_charging_id: cafe_charging_id, cafe_smoking_id: cafe_smoking_id, user_id: user_id, image: image)

      @upload.upload_tag_relations.each(&:delete)

      tag_list.each do |tag_name|
        tag = Tag.where(name: tag_name).first_or_initialize
        tag.save

        upload_tag_relation = UploadTagRelation.where(upload_id: upload.id, tag_id: tag.id).first_or_initialize
        upload_tag_relation.update(upload_id: upload.id, tag_id: tag.id)

      end
    end
    # upload = Upload.create(title: title, text: text, url: url, working_day: working_day, day_off: day_off, cafe_wifi_id: cafe_wifi_id, cafe_charging_id: cafe_charging_id, cafe_smoking_id: cafe_smoking_id, user_id: user_id, image: image)
    # map = Map.create(address: address, latitude: latitude, longitude: longitude, upload_id: upload_id)
  end

  def to_model
    upload
  end

  private

  attr_reader :upload

  def default_attributes
    {
      title: upload.title,
      text: upload.text,
      url: upload.url,
      working_day: upload.working_day,
      day_off: upload.day_off,
      cafe_wifi_id: upload.cafe_wifi_id,
      cafe_charging_id: upload.cafe_charging_id,
      cafe_smoking_id: upload.cafe_smoking_id,
      image: upload.image,
      name: upload.tags.pluck(:name).join(",")
    }
  end
end