require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿' do
    context '正常にコメントできるとき' do
      it '正しく入力すればコメントできる' do
        expect(@comment).to be_valid
      end
    end

    context '正常にコメントできないとき' do
      it '入力欄が空だとコメントできない' do
        @comment.content = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Contentを入力してください')
      end
      it '140文字以上だとコメントできない' do
        @comment.content = 'a' * 141
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Contentは140文字以内で入力してください')
      end
    end
  end

  describe 'アソシエーション' do
    context 'モデル間の関係' do
      it 'Userとの関係は1対多' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it 'Uploadとの関係は1対多' do
        expect(Comment.reflect_on_association(:upload).macro).to eq :belongs_to
      end
    end
  end
end
