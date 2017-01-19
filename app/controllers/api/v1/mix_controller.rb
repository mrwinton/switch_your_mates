class Api::V1::MixController < ApplicationController
  MIX_DESTINATION_PATH = '/root/mix_input.jpg'

  def create
    image_path = UploadAndResizeImage.new(group_image).call

    docker_path = CopyToDocker.new(target_path: image_path, destination_path: MIX_DESTINATION_PATH).call
    MixFaces.new(docker_path, close_faces: close_faces).call
    CopyFromDocker.new(destination_path: image_path).call

    render json: { :image_path => sanitised_image_path(image_path) }
  end

  private

  def close_faces
    image_params[:close_faces] == "1"
  end

  def group_image
    @group_image ||= image_params[:upload][:group_image]
  end

  def image_params
    params.permit(:close_faces, :upload => [:group_image])
  end

  def sanitised_image_path(path)
    path.sub("#{Rails.root}/public", "")
  end
end
