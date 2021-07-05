# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '正常に登録ができるとき' do
      it 'すべての値が正しく入力されていれば登録ができる' do
        expect(@user).to be_valid
      end
    end

    context '正常に登録ができないとき' do
      it 'nameが空だと登録できない' do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('氏名を入力してください')
      end
      it 'nameが12文字以上だと登録できないこと' do
        @user.name = 'a' * 13
        @user.valid?
        expect(@user.errors.full_messages).to include('氏名は12文字以内で入力してください')
      end
      it 'emailが空だと登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスが入力されていません。')
      end
      it 'emailが一意性でないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスは既に使用されています。')
      end
      it 'emailに@がないと登録できない' do
        @user.email = 'aa00'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは有効でありません。')
      end
      it 'passwordが空だと登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードが入力されていません。')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('確認用パスワードとパスワードの入力が一致しません')
      end
      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password = 'password_A'
        @user.password_confirmation = 'password_D'
        @user.valid?
        expect(@user.errors.full_messages).to include('確認用パスワードとパスワードの入力が一致しません')
      end
      it 'passwordが6文字以内だと登録できない' do
        @user.password = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上に設定して下さい。')
      end
      it 'passwordが半角英数字混合でないと登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end
      it 'passwordがすべて英字だと登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end
      it 'passwordが全角だと登録できない' do
        @user.password = 'AAAAAA'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end
      it 'profileが空だと登録できない' do
        @user.profile = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('プロフィールを入力してください')
      end
      it 'profileが300文字以上だと登録できない' do
        @user.profile = 'a' * 301
        @user.valid?
        expect(@user.errors.full_messages).to include('プロフィールは300文字以内で入力してください')
      end
      it 'avatarが空だと登録できない' do
        @user.avatar = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('プロフィール画像を入力してください')
      end
    end
  end
end
