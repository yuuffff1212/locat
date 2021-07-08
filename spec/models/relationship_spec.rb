require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'アソシエーションの検証' do
    context 'モデルとの関係' do
      it 'followingとは1対多' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
      it 'followerとは1対多' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end
  end
end
