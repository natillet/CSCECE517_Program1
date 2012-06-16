class StatisticsController < ApplicationController
  def index
    @posts = Post.all
    @users = User.all

    @average_number_comments_per_post = (Comment.count * 1.0 / Post.count)
    @average_number_posts_per_user = (Post.count * 1.0 / User.count)


  end
end
