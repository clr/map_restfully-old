require File.expand_path( File.dirname( __FILE__ ) + '/spec_helper' )

# Create a mock ActionController model.
class TestModelController < ActionController::Base
  include RestfulController
end

# This is really just a mock TestModel ActiveRecord.
class TestModel
  attr_accessor :id
  attr_accessor :data

  def self.find( *args )
    case args[0].class
    when Integer
      # TestModel.find( 1 )
      if args.length == 1
        t = self.new
        t.id = 1
        t.data = "This is one."
        return t
      # TestModel.find( 1, 2, 3 )
      else
        t_array = []
        args.each do |i|
          t = self.new
          t.id = i
          t.data = "This is number: " + i.to_s
          t_array << t
        end
        return t_array
      end
    # TestModel.find( :all )
    when Symbol
      t_array = []
      3.times do |i|
        t = self.new
        t.id = i
        t.data = "This is number: " + i.to_s
        t_array << t
      end
      return t_array
    end
  end
  
  def eql?( object )
    ( self.id == object.id ) && ( self.data == self.data )
  end
  
end

describe "RestfulController" do
  
  # Instantiate a fake ActionController.
  before( :each ) do
    @controller = TestModelController.new
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
    @controller.params[ :ids ] = "17,13,31"
    @controller.prepare_restful_instance_variables
    @controller.instance_variable_get( '@test_models' ).should eql( TestModel.find( @controller.params[ :ids ].split( ',' ) ) )
  end
  
  it "should return a default 405 response, forcing developers to explicitly define all methods for security and RESTful performance" do
    [ :singular, :plural ].each do |grammatical_number|
      %w( get post put delete ).each do |action|
        @controller.request.request_method = action
        @controller.params[ :grammatical_number ] = grammatical_number
        @controller.prepare_restful_controller_method
      
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
