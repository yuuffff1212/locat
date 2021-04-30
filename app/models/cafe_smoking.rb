class CafeSmoking < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '喫煙可' },
    { id: 2, name: '禁煙' }
  ]

  include ActiveHash::Associations
  has_many :uploads
end
