require 'rails_helper'

RSpec.describe UploadForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @upload_form = FactoryBot.build(:upload_form, user_id: @user.id)
    sleep 0.1 # 0.1秒待機
  end

  describe '新規投稿' do
  context '正常に投稿できるとき' do
    it 'すべての値が正しく入力されていれば投稿できる' do
      expect(@upload_form).to be_valid
    end
    it 'urlが空でも投稿できる' do
      @upload_form.url = nil
      expect(@upload_form).to be_valid
    end
    it 'working_dayが空でも投稿できる' do
      @upload_form.working_day = nil
      expect(@upload_form).to be_valid
    end
    it 'day_offが空でも投稿できる' do
      @upload_form.day_off = nil
      expect(@upload_form).to be_valid
    end
  end

  context '正常に投稿できないとき' do
    it 'titleが空だと投稿できない' do
      @upload_form.title = nil
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Titleを入力してください')
    end
    it 'titleが40文字以上だと投稿できない' do
      @upload_form.title = 'a' * 41
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Titleは40文字以内で入力してください')
    end
    it 'textが空だと投稿できない' do
      @upload_form.text = nil
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Textを入力してください')
    end
    it 'textが1000文字以上だと投稿できない' do
      @upload_form.text = 'a' * 1001
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Textは1000文字以内で入力してください')
    end
    it 'cafe_wifi_idが空だと投稿できない' do
      @upload_form.cafe_wifi_id = nil
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Cafe wifiを入力してください')
    end
    it 'cafe_wifi_idの値が0だと投稿できない' do
      @upload_form.cafe_wifi_id = '0'
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Cafe wifiは0以外の値にしてください')
    end
    it 'cafe_charging_idが空だと投稿できない' do
      @upload_form.cafe_charging_id = nil
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Cafe chargingを入力してください')
    end
    it 'cafe_charging_idの値が0だと投稿できない' do
      @upload_form.cafe_charging_id = '0'
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Cafe chargingは0以外の値にしてください')
    end
    it 'cafe_smoking_idが空だと投稿できない' do
      @upload_form.cafe_smoking_id = nil
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Cafe smokingを入力してください')
    end
    it 'cafe_smoking_idの値が0だと投稿できない' do
      @upload_form.cafe_smoking_id = '0'
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Cafe smokingは0以外の値にしてください')
    end
    it 'user_idが空だと投稿できない' do
      @upload_form.user_id = nil
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Userを入力してください')
    end
    it 'nameが空だと投稿できない' do
      @upload_form.name = nil
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Nameを入力してください')
    end
    it 'imageが空だと投稿できない' do
      @upload_form.image = nil
      @upload_form.valid?
      expect(@upload_form.errors.full_messages).to include('Imageを入力してください')
    end
  end
end
end
