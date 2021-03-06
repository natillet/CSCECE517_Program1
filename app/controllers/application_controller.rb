class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize_user
  before_filter :authorize_admin

  protected
    def authorize_user
      unless User.find_by_id(session[:user_id])
        redirect_to home_url, :notice => "Please log in"
      end
    end
    def authorize_admin
      authorize_user
      admin = User.find_by_id(session[:user_id])
      unless admin.is_admin?
        redirect_to home_url, :notice => "Sorry, you do not have clearance"
      end
    end
end
