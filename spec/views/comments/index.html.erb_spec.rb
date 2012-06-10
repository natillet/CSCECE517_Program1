require 'spec_helper'

# Comments are nested under posts, so their pages aren't used

#describe "comments/index" do
#  before(:each) do
#    assign(:comments, [
#      stub_model(Comment,
#        :comment => "Comment",
#        :post => nil
#      ),
#      stub_model(Comment,
#        :comment => "Comment",
#        :post => nil
#      )
#    ])
#  end
#
#  it "renders a list of comments" do
#    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "Comment".to_s, :count => 2
#    assert_select "tr>td", :text => nil.to_s, :count => 2
#  end
#end
