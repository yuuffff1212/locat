FactoryBot.define do
  factory :upload_form do
    title { 'testcafe' }
    text { 'content' }
    url { 'http' }
    working_day { '平日10:00~20:00' }
    day_off { '不定休' }
    cafe_charging_id { 1 }
    cafe_smoking_id { 1 }
    cafe_wifi_id { 1 }
    name { '東京' }
    after(:build) do |upload_form|
      upload_form.image.attach(io: File.open('public/images/test_image2.jpeg'), filename: 'test_image2.jpeg')
    end
  end
end
