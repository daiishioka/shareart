class ArtpostsController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @posts = Post.all
  end
  
  def create
    @artpost = current_user.artposts.build(artpost_params)
    if @artpost.save
      flash[:success] = '絵を投稿しました。'
      redirect_to root_url
    else
      @artposts = current_user.artposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '絵の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
  end
  
  private
  
  def artpost_params
    params.require(:artpost).permit(:artimage)
  end
end
