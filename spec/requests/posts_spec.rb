require 'spec_helper'

describe "Posts" do
  before do
    @password = "elene_pass"
    @user = User.create :name => "elene", :password_digest => (@password), :is_admin => false
    @post = Post.new
    @post.post = "Example post"
    @post.user_id = @user.id
    @post.save
  end

  describe "GET /posts" do

    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get posts_path
      response.status.should be(200)
    end

    it "displays some posts" do
      visit posts_path
      page.should have_content(@post.post)
    end

    it "displays a post's show page" do
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Show"
      end
      page.should have_content(@post.post)
    end

    it "logs in and creates a new post" do
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

  describe "PUT /posts" do
    before do
      @admin_password = "admin_pass"
      @admin_user = User.create :name => "admin", :password_digest => (@admin_password), :is_admin => true
    end
    it "fails to edit a post when not an admin" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == posts_path
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Edit"
      end
      current_path.should == home_path
      page.should have_content "Sorry, you do not have clearance"
    end

    it "edits a post (only allowed by admins)" do
      visit login_path
      fill_in "Name", :with => (@admin_user.name)
      fill_in "Password", :with => (@admin_password)
      click_button "Login"
      current_path.should == admin_path
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Edit"
      end
      current_path.should == edit_post_path(@post)
      find_field('Post').value.should == (@post.post)

      fill_in 'Post', :with => "Updated post"
      click_button 'Update Post'

      page.should have_content "Updated post"

    end
  end

  describe "DELETE /posts" do
    before do
      @admin_password = "admin_pass"
      @admin_user = User.create :name => "admin", :password_digest => (@admin_password), :is_admin => true
    end
    it "fails to delete a post when not an admin" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == posts_path
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Destroy"
      end
      current_path.should == home_path
      page.should have_content "Sorry, you do not have clearance"
    end

    it "deletes a post (only allowed by admins)" do
      visit login_path
      fill_in "Name", :with => (@admin_user.name)
      fill_in "Password", :with => (@admin_password)
      click_button "Login"
      current_path.should == admin_path
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Destroy"
      end
      current_path.should == posts_path
      page.should have_no_content(@post.post)

    end
  end
end
