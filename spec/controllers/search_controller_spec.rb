require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', {:search => "a", :searchby => "by Post"}
      response.should be_success
    end
  end

end
