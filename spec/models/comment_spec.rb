require 'spec_helper'

describe Comment do
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

  it "should search comment" do
    Comment.find_by_comment("Comment 1").should  == @comment
  end
end
