class HomeController < ApplicationController
  skip_before_filter :authorize_user
  skip_before_filter :authorize_admin
  def index
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end
end
