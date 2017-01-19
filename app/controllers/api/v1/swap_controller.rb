class Api::V1::SwapController < ApplicationController
  def create
    person_image_path = UploadAndResizeImage.new(person_image).call
    group_image_path = UploadAndResizeImage.new(group_image).call

    SwapFaces.new(person_image_path, group_image_path, close_faces: close_faces).call
    CopyFromDocker.new(destination_path: group_image_path).call

    render json: { :image_path => sanitised_image_path(group_image_path) }
  end

  private

  def close_faces
    image_params[:close_faces] == "1"
  end

  def person_image
    @person_image ||= image_params[:upload][:person_image]
  end

  def group_image
    @group_image ||= image_params[:upload][:group_image]
  end

  def image_params
    params.permit(:close_faces, :upload => [:person_image, :group_image])
  end

  def sanitised_image_path(path)
    path.sub("public", "")
  end
end
