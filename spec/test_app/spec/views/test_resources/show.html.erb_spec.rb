require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/test_resources/show.html.erb" do
  include TestResourcesHelper
  before(:each) do
    assigns[:test_resource] = @test_resource = stub_model(TestResource,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
