require File.expand_path( File.dirname( __FILE__ ) + '/spec_helper' )

describe "Restful Route Mapping" do

 # Instantiate a fake ActionController.
  before( :each ) do
    @controller = TestModelsController.new
    @controller.params = { :controller => 'test_model' }
    @controller.request = ActionController::Request.new( "REQUEST_METHOD" => 'GET' )
  end

  describe "route generation" do

    it "should map to plural routes" do
#      route_for( :controller => 'test_models', :method => 'get' ).should == "/test_models"
#      route_for( :controller => 'test_models', :method => 'post' ).should == "/test_models"
#      route_for( :controller => 'test_models', :method => 'put' ).should == "/test_models"
#      route_for( :controller => 'test_models', :method => 'delete' ).should == "/test_models"
    end

    it "should map to singular routes" do
#      route_for( :controller => 'test_model', :method => 'get' ).should == "/test_model"
#      route_for( :controller => 'test_model', :method => 'post' ).should == "/test_model"
#      route_for( :controller => 'test_model', :method => 'put' ).should == "/test_model"
#      route_for( :controller => 'test_model', :method => 'delete' ).should == "/test_model"
    end

  end

  describe "route recognition" do

    it "should generate plural params" do
      params_from( :get, "/test_models" ).should == { 
        :controller => 'test_models', 
        :action => 'gets', 
        :grammatical_number => 'plural'
      }
      params_from( :post, "/test_models" ).should == { 
        :controller => 'test_models', 
        :action => 'posts', 
        :grammatical_number => 'plural'
      }
      params_from( :put, "/test_models" ).should == { 
        :controller => 'test_models', 
        :action => 'puts', 
        :grammatical_number => 'plural'
      }
      params_from( :delete, "/test_models" ).should == { 
        :controller => 'test_models', 
        :action => 'deletes', 
        :grammatical_number => 'plural'
      }
    end

    it "should generate singular params" do
      params_from( :get,    "/test_model" ).should == { 
        :controller => 'test_models', 
        :action => 'get', 
        :grammatical_number => 'singular'
      }
      params_from( :post,    "/test_model" ).should == { 
        :controller => 'test_models', 
        :action => 'post', 
        :grammatical_number => 'singular'
      }
      params_from( :put,    "/test_model" ).should == { 
        :controller => 'test_models', 
        :action => 'put', 
        :grammatical_number => 'singular'
      }
      params_from( :delete,    "/test_model" ).should == { 
        :controller => 'test_models', 
        :action => 'delete', 
        :grammatical_number => 'singular'
      }
    end
  
    it "should generate plural params with ids" do
      params_from( :get, "/test_models/1,2,3" ).should == { 
        :controller => 'test_models', 
        :action => 'gets', 
        :ids => '1,2,3',
        :grammatical_number => 'plural'
      }
      params_from( :post, "/test_models/1,2,3" ).should == { 
        :controller => 'test_models', 
        :action => 'posts', 
        :id => '1,2,3',
        :grammatical_number => 'plural'
      }
      params_from( :put, "/test_models/1,2,3" ).should == { 
        :controller => 'test_models', 
        :action => 'puts', 
        :id => '1,2,3',
        :grammatical_number => 'plural'
      }
      params_from( :delete, "/test_models/1,2,3" ).should == { 
        :controller => 'test_models', 
        :action => 'deletes', 
        :id => '1,2,3',
        :grammatical_number => 'plural'
      }
    end

    it "should generate singular params with id" do
      params_from( :get,    "/test_model/1" ).should == { 
        :controller => 'test_models', 
        :action => 'get', 
        :id => '1',
        :grammatical_number => 'singular'
      }
      params_from( :post,    "/test_model/1" ).should == { 
        :controller => 'test_models', 
        :action => 'post', 
        :id => '1',
        :grammatical_number => 'singular'
      }
      params_from( :put,    "/test_model/1" ).should == { 
        :controller => 'test_models', 
        :action => 'put', 
        :id => '1',
        :grammatical_number => 'singular'
      }
      params_from( :delete,    "/test_model/1" ).should == { 
        :controller => 'test_models', 
        :action => 'delete', 
        :id => '1',
        :grammatical_number => 'singular'
      }
    end
  
  end

end
