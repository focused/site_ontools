# A sample Guardfile
# More info at https://github.com/guard/guard#readme


guard 'spork', cucumber_env: { 'RAILS_ENV' => 'test' }, rspec_env: { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb')            { :rspec }
  watch('spec/factories.rb')              { :rspec }
  watch(%r{^spec/support/.+_macros\.rb$}) { :rspec }
  watch('test/test_helper.rb')            { :test_unit }
  watch(%r{features/support/})            { :cucumber }
end


guard 'rspec', cli: '--colour --drb -t ~js' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})               { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')            { "spec" }
  watch('spec/factories.rb')              { "spec" }
  watch(%r{^spec/support/.+_macros\.rb$}) { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/(support|factories)/(.+)\.rb$})      { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  # Capybara request specs
  # watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
end


# uncomment this when using assets to compile them

# Make sure this guard is ABOVE any other guards using assets such as jasmine-headless-webkit
# It is recommended to make explicit list of assets in `config/application.rb`
# config.assets.precompile = ['application.js', 'application.css', 'all-ie.css']
# guard 'rails-assets' do
  # watch(%r{^app/assets/.+$})
  # watch('config/application.rb')
# end
