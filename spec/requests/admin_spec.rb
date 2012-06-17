require 'spec_helper'

describe "Admin" do
  before do
    @password = "admin"
    @user = User.create :name => "admin", :password_digest => (@password), :is_admin => true
  end

  describe "GET /admin" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get root_path
      response.status.should be(200)
    end

    it "logs in as admin" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == admin_path
      page.should have_content "Welcome to being logged in, #{@user.name}"
    end

    it "shows user creation fields" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == admin_path
      page.should have_content "Welcome to being logged in, #{@user.name}"
      page.should have_field "Name"
      page.should have_field "Password"
      page.should have_unchecked_field "user_is_admin"
      page.should have_button "Create User"
    end

    it "has link to statistics" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == admin_path
      page.should have_content "Welcome to being logged in, #{@user.name}"
      page.should have_link "Statistics (admins only!)"
    end
  end

end
