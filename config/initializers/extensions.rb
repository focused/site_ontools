require 'extensions/action_processing'

ActionController::Base.send :include, Extensions::ActionProcessing
