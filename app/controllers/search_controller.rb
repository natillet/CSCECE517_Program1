class SearchController < ApplicationController
  skip_before_filter :authorize_admin
  skip_before_filter :authorize_user
  def index
    #@comments = Comment.search(params[:search])
    @posts = Post.search(params[:search])
  end
end
