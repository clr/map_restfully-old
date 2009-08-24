require File.expand_path( File.dirname( __FILE__ ) + '/spec_helper' )

describe "RestfulController" do
  
  # Instantiate a fake ActionController.
  before( :each ) do
    @controller = TestModelsController.new
    @controller.params = { :controller => 'test_model' }
    @controller.request = ActionController::Request.new( "REQUEST_METHOD" => 'GET' )
  end

  it "should set the correct action name based on plurality" do
    @controller.params[ :grammatical_number ] = :plural
    @controller.prepare_restful_controller_method
    @controller.action_name.should ==( :gets )
  end

  it "should prepopulate a new single instance variable matching the controller name by default" do
    @controller.params[ :grammatical_number ] = :singular
    @controller.prepare_restful_instance_variables
    @controller.instance_variable_get( '@test_model' ).should eql( TestModel.new )
  end

  it "should prepopulate a specific single instance variable matching the controller name by default" do
    @controller.params[ :grammatical_number ] = :singular
    @controller.params[ :id ] = 1
    @controller.prepare_restful_instance_variables
    @controller.instance_variable_get( '@test_model' ).should eql( TestModel.find( @controller.params[ :id ] ) )
  end

  it "should prepopulate an array instance variable matching all records for the controller name by default" do
    @controller.params[ :grammatical_number ] = :plural
    @controller.prepare_restful_instance_variables
    @controller.instance_variable_get( '@test_models' ).should eql( TestModel.find( :all ) )
  end

  it "should prepopulate an array instance variable matching specific records by id for the controller name by default" do
    @controller.params[ :grammatical_number ] = :plural
    @controller.params[ :ids ] = "1,2,3"
    @controller.prepare_restful_instance_variables
    @controller.instance_variable_get( '@test_models' ).should eql( TestModel.find( @controller.params[ :ids ].split( ',' ) ) )
  end
  
end
=begin
describe TestModelController, "handling GET /active_ingredients/new.js as admin" do

  it "should be successful" do
    @controller.request.env["REQUEST_METHOD"] = "GET"
    params[ :grammatical_number ] = 'singular'
    prepare_restful_controller_method
    get
    response.should be_success
  end

end

=begin
  it "should return a default 405 response, forcing developers to explicitly define all methods for security and RESTful performance" do
        @controller.request = ActionController::Request.new( "REQUEST_METHOD" => 'GET' )
        @controller.response = ActionController::Response.new()
        @controller.params[ :grammatical_number ] = 'singular'
        @controller.prepare_restful_controller_method
raise @controller.get
    [ :singular, :plural ].each do |grammatical_number|
      %w( GET POST PUT DELETE ).each do |action|
        @controller.request = ActionController::Request.new( "REQUEST_METHOD" => action )
        @controller.response = ActionController::Response.new()
        @controller.params[ :grammatical_number ] = grammatical_number
        @controller.prepare_restful_controller_method
#        blah_req = ActionController::Request.new( "REQUEST_METHOD" => action )
#        blah_res = ActionController::Response.new()
#                @controller.process_with_test( blah_req, blah_res )
#raise @controller.send_response.finish.inspect
#raise ending.body.to_s.inspect      

        @controller.get
#  raise @controller.response.inspect
      format.html.should eql( { render :text => "
          <html>
            <body>
              <h1>405: Method not allowed.</h1>
              <p>#{ action.to_s.capitalize } called from '#{ self.class.name }' 
                with: #{ self.instance_variables.inspect }</p>
              <p>You must explicitly define this action in your controller if you wish to use it.</p>
            </body>
          </html>
          ", :status => 405 } )
      end
    end
  end

=end
