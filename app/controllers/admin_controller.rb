class AdminController < ApplicationController
  skip_before_filter :authorize_admin
  def index
    @user = User.new
  end
end
