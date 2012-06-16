describe "Posts" do
  before do
    @user = User.create :name => "elene", :password_digest => "elene", :is_admin => false
    #@post = Post.create :post => "A post"
    #@post.user_id = @user.id
  end

  describe "GET /posts" do
    before do
      @post = Post.new
      @post.post = "New post"
      @post.user_id = @user.id
    end
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get posts_path
      response.status.should be(200)
    end

    it "display some posts" do
      visit posts_path
      page.should have_content "New post"
    end

  #  it "creates a new post" do
  #    visit posts_path
  #    click_link "New Post"
  #    current_path.should == new_post_path
  #    fill_in "Post", :with => "Something green"
  #    click_button 'Create Post'
  #    #current_path.should == root_path #for if we decide to redirect to root
  #    page.should have_content "Something green"
  #  end
  end
  #
  #describe "PUT /posts" do
  #  it "edits a post" do
  #    visit posts_path
  #    click_link 'Edit'
  #    current_path.should == edit_post_path(@post)
  #
  #    #page.should have_content "A post"
  #    find_field('Post').value.should == "A post"
  #
  #    fill_in 'Post', :with => "Updated post"
  #    click_button 'Update Post'
  #
  #    page.should have_content "Updated post"
  #
  #  end
  #end

  # describe "DELETE /posts" do
  #   it "should delete a post" do
  #     visit posts_path
  #     find('#post_#{@post.id}').click_link 'Destroy'
  #     # within('tr', id: '#post_#{@post.id}') do
  #     #   click_link 'Destroy'
  #     # end
  #     page.should have_content 'Post was successfully destroyed.'
  #     page.should have_no_content "A post"
  #   end
  # end
end
