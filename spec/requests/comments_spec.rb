require 'spec_helper'

describe "Comments" do
  before do
    @password = "elene"
    @user = User.create :name => "elene", :password_digest => (@password), :is_admin => false
    @post = Post.new
    @post.post = "Example post"
    @post.user_id = @user.id
    @post.save
    @comment = Comment.new
    @comment.comment = "Example comment"
    @comment.user_id = @user.id
    @comment.post_id = @post.id
    @comment.save
  end

  describe "GET /comments" do
    it "displays some post with comment" do
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Show"
      end
      page.should have_content(@comment.comment)
    end

    it "logs in and creates a new comment" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      page.should have_content "User #{@user.name} is logged in!"
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Show"
      end
      current_path.should == post_path(@post)
      fill_in "Comment", :with => "Something green"
      click_button 'Create Comment'
      page.should have_content "Something green"
    end
  end

  describe "DELETE /comments" do
    before do
      @admin_password = "admin"
      @admin_user = User.create :name => "admin", :password_digest => (@admin_password), :is_admin => true
    end
    it "gives no option to delete a comment when not an admin" do
      visit login_path
      fill_in "Name", :with => (@user.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == posts_path
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Show"
      end
      current_path.should == post_path(@post)
      page.has_no_link?("Delete").should be_true
    end

    it "deletes a comment (only allowed by admins)" do
      visit login_path
      fill_in "Name", :with => (@admin_user.name)
      fill_in "Password", :with => (@admin_password)
      click_button "Login"
      current_path.should == admin_path
      visit posts_path
      within('tr', :text => "#{@post.post}") do
        click_link "Show"
      end
      current_path.should == post_path(@post)
      within('p', :text => "#{@comment.comment}") do
        click_link "Delete"
      end
      current_path.should == posts_path
      page.should have_no_content(@comment.comment)

    end
  end
end
