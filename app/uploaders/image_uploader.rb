class ImageUploader < BaseUploader
  # call setup_available_size method before cache image
  before :cache, :setup_available_sizes

  # we process images with a custom method (read above)
  # process dynamic_resize_to_fit: :default

  # default processing, we assume that each model has a "mini" version
  version :full do
    process dynamic_resize_to_fit: :full
  end
  version :normal do
    process dynamic_resize_to_fit: :normal
  end
  version :mini do
    process dynamic_resize_to_fit: :mini
  end

  # a lame wrapper to resize_to_fit method
  def dynamic_resize_to_fit(size)
    resize_to_fit *(model.class.image_sizes[size])
  end

  # here's the metaprogramming magic!
  # we check if the called method matches "has_VERSION_size?"
  # VERSION is a version name for image size
  def method_missing(method, *args)
    # we've already defined "has_VERSION_size?", so if a method with
    # similar name is missed, it should return false
    return false if method.to_s.match(/has_(.*)_size\?/)
    super
  end

  protected

  # the method called at the start
  # it checks for <model>::IMAGE_SIZES hash and define a custom method "has_VERSION_size?"
  # (more on this later in the article)
  def setup_available_sizes(file)
    model.class.image_sizes.keys.each do |key|
      self.class_eval do
        define_method("has_#{key}_size?".to_sym) { true }
      end
    end
  end

end
