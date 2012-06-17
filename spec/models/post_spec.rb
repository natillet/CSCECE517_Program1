require 'spec_helper'

describe Post do
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

  end

  it "should search post" do
    Post.find_by_post("Post 1").should  == @post
  end

end
