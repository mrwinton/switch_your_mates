class MixFaces
  attr_reader :group_image_path, :close_faces

  def initialize(group_image_path, close_faces:)
    @group_image_path = group_image_path
    @close_faces = close_faces
  end

  def call
    `docker exec #{docker_container} /root/facemixer.py #{host_group_image_path} #{padding}`
  end

  private

  def padding
    close_faces ? 0 : 20
  end

  def docker_container
    ENV["DOCKER_CONTAINER"]
  end

  def current_path
    `pwd`
  end

  def host_group_image_path
    "/host" + current_path.strip + "/" + group_image_path
  end
end
