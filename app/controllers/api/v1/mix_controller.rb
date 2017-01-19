class Api::V1::MixController < ApplicationController
  def create
    image_path = UploadAndResizeImage.new(group_image).call

    MixFaces.new(image_path, close_faces: close_faces).call
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
    path.sub("public", "")
  end
end
