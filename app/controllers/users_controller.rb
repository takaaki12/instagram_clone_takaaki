class UsersController < ApplicationController
  include GuestSessionsHelper
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :block_guest_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @comment = Comment.new
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)   
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Your Account deleted"
    redirect_to root_url
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def change_password
    @user = User.find(params[:id])
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:agreement, :introduction, :sex,
                                   :phone_number, :user_name, :websiteurl)
    end
  
    def correct_user
      @user = User.find(params[:id]) 
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def block_guest_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless guest_user?(@user)
    end
    
end
