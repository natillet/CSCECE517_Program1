require 'spec_helper'

# This test work on VCL environment
describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', {:search => "a", :searchby => "by Post"}
      response.should be_success
    end
  end

end
