class SearchController < ApplicationController
  skip_before_filter :authorize_user
  skip_before_filter :authorize_admin
  def index
    #@comments = Comment.search(params[:search])
    #@posts = Post.search(params[:search])
    @search = self.search_results()
  end

  def search_results
    @posts = nil
    @users = nil
    @query = params[:search]
    if !@query or @query == ""
      flash[:error] = "Search query cannot be empty"
      redirect_to :controller => 'home', :action => 'index'
    end

    if params[:searchby][:searchbyid] == "1"
        @users = User.search(params[:search])
    elsif params[:searchby][:searchbyid] == "2"
        @posts = Post.search(params[:search])
    elsif params[:searchby][:searchbyid] == "3"
        @comments = Comment.search(params[:search])
      end

  end
end
