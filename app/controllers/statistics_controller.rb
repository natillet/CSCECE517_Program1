class StatisticsController < ApplicationController
  skip_before_filter :authorize_admin

  def index
    @posts = Post.all
    @average_number_comments_per_post = 0.0
    number_of_posts = Post.count
    @posts.each do |post|
      @average_number_comments_per_post += post.comments.count
    end
    @average_number_comments_per_post /= number_of_posts

  end
end
