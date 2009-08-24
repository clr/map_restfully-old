require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/test_resources/new.html.erb" do
  include TestResourcesHelper

  before(:each) do
    assigns[:test_resource] = stub_model(TestResource,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new test_resource form" do
    render

    response.should have_tag("form[action=?][method=post]", test_resources_path) do
      with_tag("input#test_resource_name[name=?]", "test_resource[name]")
    end
  end
end
