require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'アソシエーションの検証' do
    context 'モデルとの関係' do
      it 'Userとは1対多' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it 'Uploadとは1対多' do
        expect(Favorite.reflect_on_association(:upload).macro).to eq :belongs_to
      end
    end
  end
end
