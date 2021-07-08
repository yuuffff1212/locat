FactoryBot.define do
  factory :comment do
    content { 'コメント' }
    association :user
    association :upload
  end
end
