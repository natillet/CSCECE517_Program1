require 'spec_helper'

describe "Statistics" do
  before do
    @password = "admin_pass"
    @user_admin = User.create :name => "admin", :password_digest => (@password), :is_admin => true
    @user_reg = User.create :name => "elene", :password_digest => (@password), :is_admin => false
  end

  describe "GET /statistics" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get home_path
      response.status.should be(200)
    end

    it "logs in as admin and visits statistics page" do
      visit login_path
      fill_in "Name", :with => (@user_admin.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == admin_path
      page.should have_content "Welcome to being logged in, #{@user_admin.name}"
      click_link "Statistics (admins only!)"
      current_path.should == '/statistics/index'
    end

    it "logs in as admin and visits statistics page with numbers" do
      posts = "this", "one", "apples"
      comments = "danger", "will", "robinson"
      posts.each do |post|
        a_post = Post.new
        a_post.post = post
        a_post.user_id = @user_reg.id
        a_post.save
      end
      comments.each do |comment|
        a_comment = Comment.new
        a_comment.comment = comment
        a_comment.user_id = @user_admin.id
        a_comment.post_id = 1
        a_comment.save
      end
      avg_posts_user = posts.count * 1.0 / 2
      avg_comments_post = comments.count * 1.0 / posts.count

      visit login_path
      fill_in "Name", :with => (@user_admin.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == admin_path
      page.should have_content "Welcome to being logged in, #{@user_admin.name}"
      click_link "Statistics (admins only!)"
      current_path.should == '/statistics/index'
      page.should have_content "Total number of users: 2"
      page.should have_content "Total number of posts: #{posts.count}"
      page.should have_content "Total number of comments: #{comments.count}"
      page.should have_content "Average number of posts per user: #{avg_posts_user}"
      page.should have_content "Average number of comments per post: #{avg_comments_post}"
    end
  end

  describe "EXTRA: statistics on users page" do
    it "logs in as admin and visits users page with statistics" do
      posts = "this", "one", "apples"
      admin_comments = "danger", "will", "robinson"
      user_comments = "C", "3", "P", "O"
      posts.each do |post|
        a_post = Post.new
        a_post.post = post
        a_post.user_id = @user_reg.id
        a_post.save
      end
      admin_comments.each do |comment|
        a_comment = Comment.new
        a_comment.comment = comment
        a_comment.user_id = @user_admin.id
        a_comment.post_id = 1
        a_comment.save
      end
      user_comments.each do |comment|
        a_comment = Comment.new
        a_comment.comment = comment
        a_comment.user_id = @user_reg.id
        a_comment.post_id = 1
        a_comment.save
      end
      avg_comments_post = (user_comments.count + admin_comments.count) * 1.0 / posts.count

      visit login_path
      fill_in "Name", :with => (@user_admin.name)
      fill_in "Password", :with => (@password)
      click_button "Login"
      current_path.should == admin_path
      page.should have_content "Welcome to being logged in, #{@user_admin.name}"
      click_link "Users"
      current_path.should == users_path
      within('tr', :text => "#{@user_reg.name}") do
        click_link "Show"
      end
      page.should have_content "Total posts: #{posts.count}"
      page.should have_content "Total comments: #{user_comments.count}"
      page.should have_content "Average comments received per post: #{avg_comments_post}"
    end
  end

end
