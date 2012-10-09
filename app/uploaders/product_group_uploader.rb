class ProductGroupUploader < BaseUploader
  version :main do
    process resize_to_fit: [180, 180]
  end

  version :small do
    process resize_to_fit: [160, 160]
  end

end
