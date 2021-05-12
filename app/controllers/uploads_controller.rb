class UploadsController < ApplicationController
  def index
    @uploads = Upload.all.order(created_at: :desc)
  end

  def new
    @upload_form = UploadForm.new
  end

  def create
    @upload_form = UploadForm.new(upload_params)
    if @upload_form.valid?
      @upload_form.save
      redirect_to root_path
    else
      render new
    end
  end

  def show

  end

  private

  def upload_params
    params.require(:upload_form).permit(:title, :text, :url, :working_day, :day_off, :cafe_wifi_id, :cafe_charging_id, :cafe_smoking_id, :image, :name).merge(user_id: current_user.id)
  end
end
