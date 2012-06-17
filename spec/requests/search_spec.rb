require 'spec_helper'

describe "Search" do
  #before do
  #  @password = "admin"
  #  @user = User.create :name => "admin", :password_digest => (@password), :is_admin => true
  #end

  describe "GET /search" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get home_path
      response.status.should be(200)
    end

    it "finds search on main page" do
      visit home_path
      page.should have_content "Search"
    end

    it "submits a blank search" do
      visit home_path
      fill_in "search", :with => ""
      click_button "Search"
      current_path.should == home_path
      page.should have_content "Search query cannot be empty"
    end

    it "submits a user search" do
      @user = User.create :name => "elene", :password_digest => "elene", :is_admin => false
      visit home_path
      fill_in "search", :with => "en"
      page.select("by Username", :from => "searchby_searchbyid")
      click_button "Search"
      current_path.should == '/search/index'
      page.should have_content(@user.name)
    end

    it "submits a post search" do
      @user = User.create :name => "elene", :password_digest => "elene", :is_admin => false
      @post = Post.new
      @post.post = "Inspector Gadget here!"
      @post.user_id = @user.id
      @post.save
      visit home_path
      fill_in "search", :with => "Gadget"
      page.select("by Post", :from => "searchby_searchbyid")
      click_button "Search"
      current_path.should == '/search/index'
      page.should have_content(@post.post)
    end

    it "submits a comment search" do
      @user = User.create :name => "elene", :password_digest => "elene", :is_admin => false
      @post = Post.new
      @post.post = "Inspector Gadget here!"
      @post.user_id = @user.id
      @post.save
      @comment = Comment.new
      @comment.comment = "Go go gadget arms!"
      @comment.user_id = @user.id
      @comment.post_id = @post.id
      @comment.save
      visit home_path
      fill_in "search", :with => "gadget"
      page.select("by Comment", :from => "searchby_searchbyid")
      click_button "Search"
      current_path.should == '/search/index'
      page.should have_content(@comment.comment)
    end

  end

end
