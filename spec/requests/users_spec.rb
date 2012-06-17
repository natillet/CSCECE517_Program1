require 'spec_helper'

describe "Users" do
  before do
    @password = "elene"
    @user = User.create :name => "elene", :password_digest => (@password), :is_admin => false
    @post = Post.new
    @post.post = "Example post"
    @post.user_id = @user.id
    @post.save
  end

  describe "GET /users" do

    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get posts_path
      response.status.should be(200)
    end

    it "displays some users" do
      visit posts_path
      page.should have_content(@post.post)
    end

    it "displays a user's show page" do
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Show"
      end
      page.should have_content(@post.post)
    end

    it "logs in and creates a new user" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      page.should have_content "User #{@user.name} is logged in!"
      visit posts_path
      click_link "New Post"
      current_path.should == new_post_path
      fill_in "Post", :with => "Something green"
      click_button 'Create Post'
      page.should have_content "Something green"
    end
  end

  describe "PUT /users" do
    #before do
    #  @admin_password = "admin"
    #  @admin_user = User.create :name => "admin", :password_digest => (@admin_password), :is_admin => true
    #end
    #it "fails to edit a post when not an admin" do
    #  visit login_path
    #  fill_in "Name", :with => (@user.name)
    #  fill_in "Password", :with => (@password)
    #  click_button "Login"
    #  current_path.should == posts_path
    #  visit posts_path
    #  within('tr', :text => "#{@post.post}") do
    #    click_link "Edit"
    #  end
    #  current_path.should == home_path
    #  page.should have_content "Sorry, you do not have clearance"
    #end
    #
    #it "edits a post (only allowed by admins)" do
    #  visit login_path
    #  fill_in "Name", :with => (@admin_user.name)
    #  fill_in "Password", :with => (@admin_password)
    #  click_button "Login"
    #  current_path.should == admin_path
    #  visit posts_path
    #  within('tr', :text => "#{@post.post}") do
    #    click_link "Edit"
    #  end
    #  current_path.should == edit_post_path(@post)
    #  find_field('Post').value.should == (@post.post)
    #
    #  fill_in 'Post', :with => "Updated post"
    #  click_button 'Update Post'
    #
    #  page.should have_content "Updated post"
    #
    #end
  end

  describe "DELETE /users" do
    before do
      @admin_password = "admin"
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
      visit posts_path
      within('tr', :text => "#{@user.name}") do
        click_link "Destroy"
      end
      current_path.should == posts_path
      page.should have_no_content(@user.name)

    end

    it "fails to delete last admin (only allowed by admins)" do
      visit login_path
      fill_in "Name", :with => (@admin_user.name)
      fill_in "Password", :with => (@admin_password)
      click_button "Login"
      current_path.should == admin_path
      visit posts_path
      within('tr', :text => "#{@admin_user.name}") do
        click_link "Destroy"
      end
      current_path.should == users_path
      page.should have_content "Cannot delete last remaining administrator"

    end

    it "logs out admin who deletes himself (only allowed by admins)" do
      @admin_user2 = User.create :name => "admin2", :password_digest => "admin", :is_admin => true
      visit login_path
      fill_in "Name", :with => (@admin_user.name)
      fill_in "Password", :with => (@admin_password)
      click_button "Login"
      current_path.should == admin_path
      visit posts_path
      within('tr', :text => "#{@admin_user.name}") do
        click_link "Destroy"
      end
      current_path.should == posts_path
      page.should have_content "User #{@admin_user.name} deleted"

    end
  end
end
