class GuestSessionsController < ApplicationController
  
  def create
    user = User.find_by(email: 'guest@example.com')
    log_in(user)
    flash[:success] = 'ゲストユーザーでログインしました'
    flash[:warning] = 'ご覧頂きありがとうございます！よろしくお願いします♡'
    redirect_to user
  end
end
