require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/test_resources/index.html.erb" do
  include TestResourcesHelper

  before(:each) do
    assigns[:test_resources] = [
      stub_model(TestResource,
        :name => "value for name"
      ),
      stub_model(TestResource,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of test_resources" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
