class CafeCharging < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'ăă' },
    { id: 2, name: 'ăȘă' }
  ]

  include ActiveHash::Associations
  has_many :uploads
end
