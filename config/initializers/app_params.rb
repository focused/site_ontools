
APP = YAML.load(ERB.new(File.read("#{Rails.root}/config/app_params.yml")).result)[Rails.env].symbolize_keys

APP[:debug] = false unless %w(development test).include?(Rails.env)
