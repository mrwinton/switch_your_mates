class MixFaces
  attr_reader :image_path, :close_faces

  def initialize(image_path, close_faces:)
    @image_path = image_path
    @close_faces = close_faces
  end

  def call
    `docker exec #{docker_container} /root/facemixer.py #{image_path} #{padding}`
  end

  private

  def padding
    close_faces ? 0 : 20
  end

  def docker_container
    ENV["DOCKER_CONTAINER"]
  end
end
