require "spec_helper"

#Comments are nested under posts, so their pages don't go anywhere

describe CommentsController do
  describe "routing" do
    before do
      @post_id = 1
      @id = 1
    end

    it "routes to #index" do
      get("/posts/#{@post_id}/comments").should route_to(:controller => "comments", :action => "index", :post_id => "#{@post_id}")
      #get("/posts/:post_id/comments").should route_to("comments#index")
    end

    it "routes to #new" do
      #get("/comments/new").should route_to("comments#new")
      get("/posts/#{@post_id}/comments/new").should route_to(:controller => "comments", :action => "new", :post_id => "#{@post_id}")
    end

    it "routes to #show" do
      #get("/comments/1").should route_to("comments#show", :id => "1")
      get("/posts/#{@post_id}/comments/#{@id}").should route_to(:controller => "comments", :action => "show", :id => "#{@id}", :post_id => "#{@post_id}")
    end

    it "routes to #edit" do
      #get("/comments/1/edit").should route_to("comments#edit", :id => "1")
      get("/posts/#{@post_id}/comments/#{@id}/edit").should route_to(:controller => "comments", :action => "edit", :id => "#{@id}", :post_id => "#{@post_id}")
    end

    it "routes to #create" do
      #post("/comments").should route_to("comments#create")
      post("/posts/#{@post_id}/comments").should route_to(:controller => "comments", :action => "create", :post_id => "#{@post_id}")
    end

    it "routes to #update" do
      #put("/comments/1").should route_to("comments#update", :id => "1")
      put("/posts/#{@post_id}/comments/#{@id}").should route_to(:controller => "comments", :action => "update", :id => "#{@id}", :post_id => "#{@post_id}")
    end

    it "routes to #destroy" do
      #delete("/comments/1").should route_to("comments#destroy", :id => "1")
      delete("/posts/#{@post_id}/comments/#{@id}").should route_to(:controller => "comments", :action => "destroy", :id => "#{@id}", :post_id => "#{@post_id}")
    end

  end
end
