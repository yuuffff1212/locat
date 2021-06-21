# frozen_string_literal: true

module Api
  class FavoritesController < ActionController::API
    before_action :authenticate_user!

    def index
      render json: Favorite.filter_by_upload(params[:upload_id]).select(:id, :user_id, :upload_id)
    end

    def create
      @uploads = Upload.find(params[:upload_id])
      current_user.favorites.create!(favorites_params)
      head :created
    end

    def destroy
      current_user.favorites.find(params[:id]).destroy!
      head :ok
    end

    private

    def favorites_params
      params.require(:favorite).permit(:upload_id)
    end
  end
end

