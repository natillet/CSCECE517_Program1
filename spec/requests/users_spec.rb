require 'spec_helper'

describe "Users" do
  before do
    @password = "elene_pass"
    @user = User.create :name => "elene", :password_digest => (@password), :is_admin => false
  end

  describe "GET /users" do

    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get users_path
      response.status.should be(200)
    end

    it "displays some users" do
      visit users_path
      page.should have_content(@user.name)
    end

    it "displays a user's show page" do
      visit users_path
      within('tr', :text => "#{@user.name}") do
        click_link "Show"
      end
      page.should have_content(@user.name)
    end

    it "logs in and creates a new user" do
      visit users_path
      click_link "New User"
      fill_in "Name", :with => "new_user"
      fill_in "Password", :with => "new_user"
      click_button "Create User"
      page.should have_content "User was successfully created"
    end
  end

  describe "PUT /users" do
    before do
      @admin_password = "admin_pass"
      @admin_user = User.create :name => "admin", :password_digest => (@admin_password), :is_admin => true
    end
    it "fails to edit a user when not logged in" do
      visit "/users/1/edit"
      current_path.should == home_path
      page.should have_content "Please log in"
    end
    it "fails to edit a user when not an admin" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == posts_path
      visit "/users/1/edit"
      current_path.should == home_path
      page.should have_content "Sorry, you do not have clearance"
    end

    it "fails to edit user, even as admin" do
      visit login_path
      fill_in "Name", :with => (@admin_user.name)
      fill_in "Password", :with => (@admin_password)
      click_button "Login"
      current_path.should == admin_path
      visit "/users/1/edit"
      current_path.should == home_path
      page.should have_content "Editing of users is forbidden"

    end
  end

  describe "DELETE /users" do
    before do
      @admin_password = "admin_pass"
      @admin_user = User.create :name => "admin", :password_digest => (@admin_password), :is_admin => true
    end
    it "fails to delete a user when not logged in" do
      visit users_path
      within('tr', :text => "#{@user.name}") do
        click_link "Destroy"
      end
      current_path.should == home_path
      page.should have_content "Please log in"
    end
    it "fails to delete a user when not an admin" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == posts_path
      visit users_path
      within('tr', :text => "#{@user.name}") do
        click_link "Destroy"
      end
      current_path.should == home_path
      page.should have_content "Sorry, you do not have clearance"
    end

    it "deletes a user (only allowed by admins)" do
      visit login_path
      fill_in "Name", :with => (@admin_user.name)
      fill_in "Password", :with => (@admin_password)
      click_button "Login"
      current_path.should == admin_path
      visit users_path
      within('tr', :text => "#{@user.name}") do
        click_link "Destroy"
      end
      current_path.should == users_path
      page.should have_content "User #{@user.name} deleted"

    end

    it "fails to delete last admin (only allowed by admins)" do
      visit login_path
      fill_in "Name", :with => (@admin_user.name)
      fill_in "Password", :with => (@admin_password)
      click_button "Login"
      current_path.should == admin_path
      visit users_path
      within('tr', :text => "#{@admin_user.name}") do
        click_link "Destroy"
      end
      current_path.should == users_path
      page.should have_content "Cannot delete last remaining administrator"

    end

    it "logs out admin who deletes himself (only allowed by admins)" do
      @admin_user2 = User.create :name => "admin2", :password_digest => "admin_pass", :is_admin => true
      visit login_path
      fill_in "Name", :with => (@admin_user.name)
      fill_in "Password", :with => (@admin_password)
      click_button "Login"
      current_path.should == admin_path
      visit users_path
      within('tr', :text => "#{@admin_user.name}") do
        click_link "Destroy"
      end
      current_path.should == users_path
      page.should have_content "User #{@admin_user.name} deleted"
      page.should have_link "Login"

    end
  end
end
