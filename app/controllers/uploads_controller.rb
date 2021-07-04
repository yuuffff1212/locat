class UploadsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_upload, only: [:show, :edit, :update, :destroy]


  def index
    @uploads = Upload.all.order(created_at: :desc)
    @tag_list = Tag.all
  end

  def new
    @upload_form = UploadForm.new
  end

  def create
    @upload_form = UploadForm.new(upload_params)
    tag_list = params[:upload][:name].split(",")
    if @upload_form.valid?
      @upload_form.save(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @tag = @upload.tags
    @comment = Comment.new
    @comments = @upload.comments.order(created_at: :desc)
  end

  def edit
    @upload_form = UploadForm.new(upload: @upload)
    if current_user.id != @upload.user.id
      redirect_to root_path
    end
  end

  def update
    @upload_form = UploadForm.new(upload_params, upload: @upload)
    tag_list = params[:upload][:name].split(",")
    if @upload_form.valid?
      @upload_form.save(tag_list)
      redirect_to upload_path(@upload.id)
    else
      render :edit
    end
  end

  def destroy
    @upload.image.purge if @upload.image.attached?
    if current_user.id == @upload.user.id
      @upload.destroy
      redirect_to root_path
    else
      render :show
    end

  end

  private

  def upload_params
    params.require(:upload).permit(:title, :text, :url, :working_day, :day_off, :cafe_wifi_id, :cafe_charging_id, :cafe_smoking_id, :image, :name).merge(user_id: current_user.id)
  end

  def set_upload
    @upload = Upload.find(params[:id])
  end
end
