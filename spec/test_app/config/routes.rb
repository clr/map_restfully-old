ActionController::Routing::Routes.draw do |map|
  map.restfully :test_resource

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
