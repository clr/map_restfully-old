require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TestResourcesController do

  def mock_test_resource(stubs={})
    @mock_test_resource ||= mock_model(TestResource, stubs)
  end

  describe "GET index" do
    it "assigns all test_resources as @test_resources" do
      TestResource.stub!(:find).with(:all).and_return([mock_test_resource])
      get :index
      assigns[:test_resources].should == [mock_test_resource]
    end
  end

  describe "GET show" do
    it "assigns the requested test_resource as @test_resource" do
      TestResource.stub!(:find).with("37").and_return(mock_test_resource)
      get :show, :id => "37"
      assigns[:test_resource].should equal(mock_test_resource)
    end
  end

  describe "GET new" do
    it "assigns a new test_resource as @test_resource" do
      TestResource.stub!(:new).and_return(mock_test_resource)
      get :new
      assigns[:test_resource].should equal(mock_test_resource)
    end
  end

  describe "GET edit" do
    it "assigns the requested test_resource as @test_resource" do
      TestResource.stub!(:find).with("37").and_return(mock_test_resource)
      get :edit, :id => "37"
      assigns[:test_resource].should equal(mock_test_resource)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created test_resource as @test_resource" do
        TestResource.stub!(:new).with({'these' => 'params'}).and_return(mock_test_resource(:save => true))
        post :create, :test_resource => {:these => 'params'}
        assigns[:test_resource].should equal(mock_test_resource)
      end

      it "redirects to the created test_resource" do
        TestResource.stub!(:new).and_return(mock_test_resource(:save => true))
        post :create, :test_resource => {}
        response.should redirect_to(test_resource_url(mock_test_resource))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved test_resource as @test_resource" do
        TestResource.stub!(:new).with({'these' => 'params'}).and_return(mock_test_resource(:save => false))
        post :create, :test_resource => {:these => 'params'}
        assigns[:test_resource].should equal(mock_test_resource)
      end

      it "re-renders the 'new' template" do
        TestResource.stub!(:new).and_return(mock_test_resource(:save => false))
        post :create, :test_resource => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested test_resource" do
        TestResource.should_receive(:find).with("37").and_return(mock_test_resource)
        mock_test_resource.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :test_resource => {:these => 'params'}
      end

      it "assigns the requested test_resource as @test_resource" do
        TestResource.stub!(:find).and_return(mock_test_resource(:update_attributes => true))
        put :update, :id => "1"
        assigns[:test_resource].should equal(mock_test_resource)
      end

      it "redirects to the test_resource" do
        TestResource.stub!(:find).and_return(mock_test_resource(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(test_resource_url(mock_test_resource))
      end
    end

    describe "with invalid params" do
      it "updates the requested test_resource" do
        TestResource.should_receive(:find).with("37").and_return(mock_test_resource)
        mock_test_resource.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :test_resource => {:these => 'params'}
      end

      it "assigns the test_resource as @test_resource" do
        TestResource.stub!(:find).and_return(mock_test_resource(:update_attributes => false))
        put :update, :id => "1"
        assigns[:test_resource].should equal(mock_test_resource)
      end

      it "re-renders the 'edit' template" do
        TestResource.stub!(:find).and_return(mock_test_resource(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested test_resource" do
      TestResource.should_receive(:find).with("37").and_return(mock_test_resource)
      mock_test_resource.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the test_resources list" do
      TestResource.stub!(:find).and_return(mock_test_resource(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(test_resources_url)
    end
  end

end
