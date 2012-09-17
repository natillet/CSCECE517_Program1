require 'spec_helper'

describe SessionsController do
  def valid_attributes
    {
      :name => "admin",
      :password_digest => "admin_pass",
      :is_admin => true
    }
  end
  def valid_session
    {
      :user_id => 1
    }
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST /create" do
    it "authenticates and assigns session[:user_id]" do
      #italktoomuch.com/2012/05/testing-user-authentication-in-rails-with-rspec
      user = User.create! valid_attributes
      post :create, {:name => user.name, :password => "admin_pass"}
      session[:user_id].should eq(user.id)
    end
    it "should fail to login a mismatch password" do
      user = User.create! valid_attributes
      post :create, {:name => user.name, :password => "no"}
      session[:user_id].should be_nil
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      user = User.create! valid_attributes
      session[:user_id] = 1
      get :destroy
      #response.should be_success
      response.code.should eq("302")
      session[:user_id].should be_nil
    end
  end

end
