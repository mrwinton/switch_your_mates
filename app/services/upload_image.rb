class UploadImage
  attr_reader :image, :destination

  def initialize(image, destination:)
    @image = image
    @destination = destination
  end

  def call
    File.open(destination, "wb") { |f| f.write(image.read) }
  end
end
