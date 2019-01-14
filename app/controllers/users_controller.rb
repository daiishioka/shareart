class UsersController < ApplicationController
  before_action 'require_user_logged_in', only: [:index, :show, :artposts, :followings, :followers, :likes, :update]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @artposts = @user.artposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザ登録が完了しました！'
      session[:user_id] = @user.id
      redirect_to edit_user_path(@user)
    else
      flash.now[:danger] = 'ユーザ登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = 'プロフィールを編集しました'
        redirect_to @user
      else
        respond_to do |format|
          flash.now[:danger] = 'プロフィールの編集に失敗しました'
          render :edit
        end
      end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @artposts = @user.likes.page(params[:page])
    counts(@user)
    render :show
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :instagram_url, :twitter_url, :facebook_url, :introduction, :image)
  end

end
