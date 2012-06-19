require 'spec_helper'

describe AdminController do

  def valid_attributes
    {
        :name => "admin",
        :password_digest => "admin_pass",
        :is_admin => true
    }
  end
  def valid_session
    {
        :user_id => 1    #assumes that there is a first user who is an admin
    }
  end

  describe "GET 'index'" do
    it "returns http success" do
      user = User.create! valid_attributes
      get :index, {}, valid_session
      #get 'index'
      response.should be_success
    end
  end

end
