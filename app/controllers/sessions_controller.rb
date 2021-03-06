class SessionsController < ApplicationController
  skip_before_filter :authorize_user
  skip_before_filter :authorize_admin
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      if user.is_admin?
        redirect_to admin_url
      else
        redirect_to posts_url
      end
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_url, :notice => "Logged out"
  end
end
