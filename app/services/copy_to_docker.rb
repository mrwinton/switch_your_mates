class CopyToDocker
  attr_reader :target_path, :destination_path

  def initialize(target_path:, destination_path:)
    @target_path = target_path
    @destination_path = destination_path
  end

  def call
    `docker cp #{target_path} #{docker_container}:#{destination_path}`

    destination_path
  end

  def docker_container
    ENV["DOCKER_CONTAINER"]
  end
end
