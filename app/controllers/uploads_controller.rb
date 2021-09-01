class UploadsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search]
  before_action :set_upload, only: %i[show edit update destroy]
  before_action :search_category_upload, only: %i[index category]

  def index
    @uploads = Upload.all.order(created_at: :desc)
    @tag_list = Tag.all
    @ranks = Upload.create_ranks
    @q = Upload.ransack(params[:q])
    @uploads = @q.result(distinct: true)
  end

  def new
    @upload_form = UploadForm.new
  end

  def create
    @upload_form = UploadForm.new(upload_params)
    tag_list = params[:upload][:name].split(',')
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
    tag_list = params[:upload][:name].split(',')
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

  def search
    @uploads = Upload.search(params[:keyword])
    @q = Upload.search(search_params)
    @uploads = @q.result(distinct: true)
  end

  def category
    @results = @q.result
  end

  private

  def upload_params
    params.require(:upload).permit(:title, :text, :url, :working_day, :day_off, :cafe_wifi_id, :cafe_charging_id,
                                   :cafe_smoking_id, :image, :name).merge(user_id: current_user.id)
  end

  def set_upload
    @upload = Upload.find(params[:id])
  end

  def search_category_upload
    @q = Upload.ransack(params[:q])
  end

  def search_params
    params.require(:q).permit!
  end
end
