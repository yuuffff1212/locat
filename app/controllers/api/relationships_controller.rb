# frozen_string_literal: true

module Api
  class RelationshipsController < ActionController::API
    before_action :authenticate_user!

    def index
      render json: Relationship.filter_by_followed(params[:followed_id]).select(:id, :follower_id, :followed_id)
    end

    def create
      @user = User.find(params[:followed_id])
      current_user.active_relationships.create!(relationships_params)
      head :created
    end

    def destroy
      current_user.active_relationships.find(params[:id]).destroy!
      head :ok
    end
  end

  private

  def relationships_params
    params.require(:relationship).permit(:followed_id)
  end
end
