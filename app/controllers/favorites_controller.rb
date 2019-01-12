class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    artpost = Artpost.find(params[:artpost_id])
    current_user.like(artpost)
    flash[:success] = '投稿をお気に入りしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    artpost = Artpost.find(params[:artpost_id])
    current_user.unlike(artpost)
    flash[:success] = 'お気に入りを解除しました'
    redirect_back(fallback_location: root_path)
  end
end
