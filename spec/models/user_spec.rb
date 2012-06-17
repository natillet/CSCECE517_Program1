require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = User.new
    @user.name = "Neelam"
    @user.password_digest = "neelam"
    @user.is_admin = true
    @user.save

    @post = Post.new
    @post.post = "Post 1"
    @post.user_id = @user.id
    @post.save

    @comment = Comment.new
    @comment.comment = "Comment 1"
    @comment.user_id = @user.id
    @comment.post_id = @post.id
    @comment.save
  end

  it "allows access to user name attribute" do
    user = User.new(:name => 'Neelam')
    user.name.should eq('Neelam')
  end

  it "allows access to the password attributes" do
    user = User.new(:name => 'Neelam', :password_digest => 'neelam')
    user.password_digest.should eq('neelam')
  end

  it "allows access to is admin attribute" do
    user = User.new(:is_admin => true)
    user.is_admin.should eq(true)
  end

  it "validates presence of user name attribute" do
    user = User.new(:password_digest => 'neelam')
    user.save
    user.should have(1).errors_on(:name)
  end

  it "validates uniqueness of user name attribute" do
    user = User.new(
        :name => 'Neelam',
        :password_digest => 'neelam'
    )
    user.save
    user2 = User.new(
        :name => 'Neelam',
        :password_digest => 'neelam'
    )
    user2.should have(1).errors_on(:name)
  end

  it "should authenticate user" do
    submitted_password = Digest::SHA2.hexdigest("neelam")
    submitted_password.should == @user.password_digest
  end

  it "should count number of posts" do
    Post.count.should == 1
  end

  it "should count number of comments" do
    Comment.count.should == 1
  end

  it "should search user" do
    User.find_by_name("Neelam").should  == @user
  end

  it "should ensure an admin remains" do
    if User.where(:is_admin => true).count.zero? == false
    end
  end

end