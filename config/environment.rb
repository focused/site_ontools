# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SiteOne::Application.initialize!

Haml::Template.options[:format] = :xhtml
