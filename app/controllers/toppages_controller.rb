class ToppagesController < ApplicationController
  def index
    if logged_in?
      @artpost = current_user.artposts.build
      @artposts = current_user.artposts.order('created_at DESC').page(params[:page])
    end
  end
end