# FOG_ENVS = %w(production stage)
FOG_ENVS = %w()

CarrierWave.configure do |config|
  if FOG_ENVS.include? Rails.env
    config.storage = :fog

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: APP[:s3]['key'],
      aws_secret_access_key: APP[:s3]['secret']
      # :region => 'eu-west-1' # optional, defaults to 'us-east-1'
    }
    config.fog_directory = APP[:s3]['directory']
    config.fog_public = true
    # config.fog_host = 'https://localhost:3000' # optional, defaults to nil
    # config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' } # optional, defaults to {}
    config.fog_authenticated_url_expiration = 5

    # if caching from s3 – important for heroku (default public/upload)
    config.cache_dir = File.join(Rails.root, 'tmp', 's3', Rails.env)
  else
    config.storage = :file
    config.cache_dir = File.join(Rails.root, 'tmp', 'uploads')
    config.enable_processing = false if ['test'].include? Rails.env
  end
end

# unicode for different languages
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:][^ \t-~]\.\-\+]/
