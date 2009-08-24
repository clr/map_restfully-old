require File.expand_path( File.join( File.dirname( __FILE__ ), 'restful_controller' ) )
require File.expand_path( File.join( File.dirname( __FILE__ ), 'restful_mapper' ) )

#if Object.constants.collect{ |k| k.to_sym }.include?( :ActionController )
  # Do we need to actually do something?
#else
#  raise "The map_restfully gem doesn't work [or make sense] outside of Rails."
#end 
