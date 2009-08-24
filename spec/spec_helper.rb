ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/test_app/config/environment" unless defined?(RAILS_ROOT)

require 'spec/autorun'
require 'spec/rails'

require File.join( File.dirname( __FILE__ ), 'test_model' )
require File.join( File.dirname( __FILE__ ), 'test_models_controller' )

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  config.global_fixtures = :test_models
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end

=begin
$LOAD_PATH.unshift( File.dirname( __FILE__ ) )
$LOAD_PATH.unshift( File.join( File.dirname( __FILE__ ), '..', 'lib' ) )

# Bootstrap the ActionController module.
require 'rubygems'
require 'rbconfig'
require 'find'
require 'ftools'
require 'action_controller/vendor/rack-1.0/rack'
require 'activesupport'
module ActionController
  # TODO: Review explicit to see if they will automatically be handled by
  # the initilizer if they are really needed.
  def self.load_all!
    [Base, CGIHandler, CgiRequest, Request, Response, Http::Headers, UrlRewriter, UrlWriter]
  end

  autoload :AbstractRequest, 'action_controller/request'
  autoload :Base, 'action_controller/base'
  autoload :Benchmarking, 'action_controller/benchmarking'
  autoload :Caching, 'action_controller/caching'
  autoload :Cookies, 'action_controller/cookies'
  autoload :Dispatcher, 'action_controller/dispatcher'
  autoload :Failsafe, 'action_controller/failsafe'
  autoload :Filters, 'action_controller/filters'
  autoload :Flash, 'action_controller/flash'
  autoload :Helpers, 'action_controller/helpers'
  autoload :HttpAuthentication, 'action_controller/http_authentication'
  autoload :Integration, 'action_controller/integration'
  autoload :IntegrationTest, 'action_controller/integration'
  autoload :Layout, 'action_controller/layout'
  autoload :MiddlewareStack, 'action_controller/middleware_stack'
  autoload :MimeResponds, 'action_controller/mime_responds'
  autoload :ParamsParser, 'action_controller/params_parser'
  autoload :PolymorphicRoutes, 'action_controller/polymorphic_routes'
  autoload :RecordIdentifier, 'action_controller/record_identifier'
  autoload :Reloader, 'action_controller/reloader'
  autoload :Request, 'action_controller/request'
  autoload :RequestForgeryProtection, 'action_controller/request_forgery_protection'
  autoload :Rescue, 'action_controller/rescue'
  autoload :Resources, 'action_controller/resources'
  autoload :Response, 'action_controller/response'
  autoload :RewindableInput, 'action_controller/rewindable_input'
  autoload :Routing, 'action_controller/routing'
  autoload :SessionManagement, 'action_controller/session_management'
  autoload :StatusCodes, 'action_controller/status_codes'
  autoload :Streaming, 'action_controller/streaming'
  autoload :TestCase, 'action_controller/test_case'
  autoload :TestProcess, 'action_controller/test_process'
  autoload :Translation, 'action_controller/translation'
  autoload :UploadedFile, 'action_controller/uploaded_file'
  autoload :UploadedStringIO, 'action_controller/uploaded_file'
  autoload :UploadedTempfile, 'action_controller/uploaded_file'
  autoload :UrlRewriter, 'action_controller/url_rewriter'
  autoload :UrlWriter, 'action_controller/url_rewriter'
  autoload :Verification, 'action_controller/verification'

  module Assertions
    autoload :DomAssertions, 'action_controller/assertions/dom_assertions'
    autoload :ModelAssertions, 'action_controller/assertions/model_assertions'
    autoload :ResponseAssertions, 'action_controller/assertions/response_assertions'
    autoload :RoutingAssertions, 'action_controller/assertions/routing_assertions'
    autoload :SelectorAssertions, 'action_controller/assertions/selector_assertions'
    autoload :TagAssertions, 'action_controller/assertions/tag_assertions'
  end

  module Http
    autoload :Headers, 'action_controller/headers'
  end

  module Session
    autoload :AbstractStore, 'action_controller/session/abstract_store'
    autoload :CookieStore, 'action_controller/session/cookie_store'
    autoload :MemCacheStore, 'action_controller/session/mem_cache_store'
  end

  # DEPRECATE: Remove CGI support
  autoload :CgiRequest, 'action_controller/cgi_process'
  autoload :CGIHandler, 'action_controller/cgi_process'
end

autoload :Mime, 'action_controller/mime_type'

autoload :HTML, 'action_controller/vendor/html-scanner'

require 'action_view'
ENV["RAILS_ENV"] = "test"
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION
require File.expand_path( File.dirname( __FILE__ ) + '/boot' )
Rails::Initializer.run do |config|
end

require 'spec/rails'
require 'map_restfully'

Spec::Runner.configure do |config|
end

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

ActionController::Routing::Routes.draw do |map|
  map.restfully :test_models
=end
