class MicropostsController < ApplicationController
 before_action :logged_in_user, only: [:create, :destroy]
 before_action :correct_user,   only: :destroy

 
 def create
  @micropost = current_user.microposts.build(micropost_params)
  @micropost.image.attach(params[:micropost][:image])
  if @micropost.save
    flash[:success] = "Micropost created!"
    redirect_to micropost_path(@micropost)
  else
    @feed_items = current_user.feed.paginate(page: params[:page])
    render 'static_pages/home'
  end
 end

 def destroy 
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
 end
 
 def show 
    @micropost = Micropost.find(params[:id])
    @comment = Comment.new
    @user = User.find_by(id: @micropost.user_id)
    @like = Like.new
 end
 
 def search
    @microposts = Micropost.search(params[:search])
 end
 
 def form
    @micropost  = current_user.microposts.build
 end
 
 def modal
    @micropost = Micropost.find(params[:id])
    @user = User.find(@micropost_params[:id])
 end
 
 private

    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
