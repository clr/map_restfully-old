require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TestResourcesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "test_resources", :action => "index").should == "/test_resources"
    end

    it "maps #new" do
      route_for(:controller => "test_resources", :action => "new").should == "/test_resources/new"
    end

    it "maps #show" do
      route_for(:controller => "test_resources", :action => "show", :id => "1").should == "/test_resources/1"
    end

    it "maps #edit" do
      route_for(:controller => "test_resources", :action => "edit", :id => "1").should == "/test_resources/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "test_resources", :action => "create").should == {:path => "/test_resources", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "test_resources", :action => "update", :id => "1").should == {:path =>"/test_resources/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "test_resources", :action => "destroy", :id => "1").should == {:path =>"/test_resources/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/test_resources").should == {:controller => "test_resources", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/test_resources/new").should == {:controller => "test_resources", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/test_resources").should == {:controller => "test_resources", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/test_resources/1").should == {:controller => "test_resources", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/test_resources/1/edit").should == {:controller => "test_resources", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/test_resources/1").should == {:controller => "test_resources", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/test_resources/1").should == {:controller => "test_resources", :action => "destroy", :id => "1"}
    end
  end
end
