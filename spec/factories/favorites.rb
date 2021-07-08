FactoryBot.define do
  factory :favorite do
    association :user
    association :upload
  end
end
