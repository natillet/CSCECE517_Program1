class SearchController < ApplicationController
  def index
    #@comments = Comment.search(params[:search])
    @posts = Post.search(params[:search])
  end
end
