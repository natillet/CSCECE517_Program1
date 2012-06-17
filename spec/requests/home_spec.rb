require 'spec_helper'

describe "Home" do
  describe "GET /home" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get home_path
      response.status.should be(200)
    end

    it "shows navigation bar" do
      visit home_path
      page.should have_link "Home"
      page.should have_link "Posts"
      page.should have_link "Users"
      page.should have_link "Login"
    end

    it "shows Search" do
      visit home_path
      page.should have_field "search"
      page.should have_select "searchby_searchbyid"
      page.should have_button "Search"
    end

    it "shows User creation fields" do
      visit home_path
      page.should have_field "Name"
      page.should have_field "Password"
      page.should have_button "Create User"
    end

    it "creates a user from the home page" do
      visit home_path
      fill_in "Name", :with => "new_person"
      fill_in "Password", :with => "secret"
      click_button "Create User"
      visit users_path
      page.should have_content "new_person"
    end

  end

end
