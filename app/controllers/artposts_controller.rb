class ArtpostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @posts = Post.all
  end
  
  def create
    @artpost = current_user.artposts.build(artpost_params)
    if @artpost.save
      flash[:success] = '絵を投稿しました。'
      redirect_to root_url
    else
      @artposts = current_user.feed_artposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '絵の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @artpost.destroy
    flash[:success] = '投稿を削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def artpost_params
    params.require(:artpost).permit(:artimage) if params[:artpost]
  end
    
  def correct_user
    @artpost = current_user.artposts.find_by(id: params[:id])
    unless @artpost
      redirect_to root_url
    end
  end
end
