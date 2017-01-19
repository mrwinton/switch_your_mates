class UploadAndResizeImage
  attr_reader :image

  DIRECTORY = Rails.root.to_s + '/public/images/upload'

  def initialize(image)
    @image = image
  end

  def call
    UploadImage.new(image, destination: path(image_name)).call
    ResizeImage.new(target: path(image_name), destination: path(resized_image_name)).call

    path(resized_image_name)
  end

  private

  def image_name
    image.original_filename
  end

  def resized_image_name
    'resized_' + image_name
  end

  def path(name)
    File.join(DIRECTORY, name)
  end
end
