class CopyFromDocker
  attr_reader :destination_path

  def initialize(destination_path:)
    @destination_path = destination_path
  end

  def call
    `docker cp #{docker_container}:/root/output.jpg #{destination_path}`
  end

  private

  def docker_container
    ENV["DOCKER_CONTAINER"]
  end
end
