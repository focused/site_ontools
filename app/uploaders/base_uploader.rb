class BaseUploader < CarrierWave::Uploader::Base
  before :store, :remember_cache_id
  before :cache, :remove_old_file_before_cache
  # after :store, :delete_tmp_dir

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{model.id}_#{mounted_as}"
  end

  # store! nil's the cache_id after it finishes so we need to remember it for deletion
  def remember_cache_id(new_file)
    @cache_id_was = cache_id
  end

  # def delete_tmp_dir(new_file)
  #   # make sure we don't delete other things accidentally by checking the name pattern
  #   if @cache_id_was.present? && @cache_id_was =~ /\A[\d]{8}\-[\d]{4}\-[\d]+\-[\d]{4}\z/
  #     FileUtils.rm_rf(File.join(cache_dir, @cache_id_was))
  #   end
  # end

  def remove_old_file_before_cache(new_file)
    remove! unless blank?
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Process files as they are uploaded:
  process resize_to_fit: [1000, 1000]

  version :thumb, if: 'thumbnable?' do
    process resize_to_fit: [48, 48]
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    if version_name == :thumb
      asset_path "#{version_name}_default.png"
    else
      asset_path "#{model.class.name.underscore.pluralize}/" + [version_name, "default.png"].compact.join('_')
    end
  rescue
    'default.png'
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  protected

  def thumbnable?(new_file)
    return model.class.thumbnable? if model.respond_to? :thumbnable?
    true
  end

end
