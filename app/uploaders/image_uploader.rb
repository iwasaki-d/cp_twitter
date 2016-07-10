# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  MAX_IMAGE_HEIGHT_PIXELS = 800
  MAX_IMAGE_WIDTH_PIXELS = 800

  THUMB_IMAGE_HEIGHT_PIXELS = 80
  THUMB_IMAGE_WIDTH_PIXELS = 80

  storage :file

  process resize_to_limit: [MAX_IMAGE_WIDTH_PIXELS, MAX_IMAGE_HEIGHT_PIXELS]

  process :dimensions

  process convert: 'jpg'


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [THUMB_IMAGE_WIDTH_PIXELS, THUMB_IMAGE_HEIGHT_PIXELS]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end

  def filename
    "#{Time.now.strftime('%Y%m%d%H%M%S')}.jpg" if original_filename.present?
  end

  def dimensions
    if file && model
      img = ::Magick::Image::read(file.file).first
      {width: img.columns, height: img.rows}
    end
  end
end
