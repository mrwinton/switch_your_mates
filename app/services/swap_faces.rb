class SwapFaces
  attr_reader :person_image_path, :group_image_path, :close_faces

  def initialize(person_image_path, group_image_path, close_faces:)
    @person_image_path = person_image_path
    @group_image_path = group_image_path
    @close_faces = close_faces
  end

  def call
    `docker exec #{docker_container} /root/faceswap.py #{person_image_path} #{group_image_path} #{padding}`
  end

  private

  def padding
    close_faces ? 0 : 20
  end

  def docker_container
    ENV["DOCKER_CONTAINER"]
  end
end
