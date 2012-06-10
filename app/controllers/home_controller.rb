class HomeController < ApplicationController
  def index
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end
end
