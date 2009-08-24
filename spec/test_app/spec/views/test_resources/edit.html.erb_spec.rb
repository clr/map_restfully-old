require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/test_resources/edit.html.erb" do
  include TestResourcesHelper

  before(:each) do
    assigns[:test_resource] = @test_resource = stub_model(TestResource,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit test_resource form" do
    render

    response.should have_tag("form[action=#{test_resource_path(@test_resource)}][method=post]") do
      with_tag('input#test_resource_name[name=?]', "test_resource[name]")
    end
  end
end
