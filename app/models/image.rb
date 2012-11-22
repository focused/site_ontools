require 'validators/file_size_validator'

class Image < ActiveRecord::Base
  attr_accessible :content_type, :file, :file_size, :name, :position
  attr_accessible :file_cache, :remove_file

  class_attribute :image_sizes

  belongs_to :owner, polymorphic: true

  mount_uploader :file, ImageUploader

  default_scope order(:position)

  before_save :update_file_attributes
  after_destroy :clear_files

  validates :file, file_size: { maximum: 1.megabytes.to_i }, if: lambda { |o| o.file_cache.blank? }

  private
  # delete attached file and its versions if present
  def clear_files
    FileUtils.rm_rf(File.dirname(self.file.current_path)) unless file.current_path.nil?
  end

  def update_file_attributes
    if file.file
      self.content_type = file.file.content_type
      self.file_size = file.file.size
      self.name ||= File.basename(self.file.to_s)
    end
  end
end
