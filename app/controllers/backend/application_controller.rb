class Backend::ApplicationController < ActionController::Base
  include Extensions::ActionRescue
  include Extensions::ActionLocations

  protect_from_forgery
end
