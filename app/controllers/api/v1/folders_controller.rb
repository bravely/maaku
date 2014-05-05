class Api::V1::FoldersController < ApplicationController
  respond_to :json
  before_action :find_folder, only: [:show, :update, :destroy]

  def index
    respond_with Folder.all, each_serializer: ShallowFolderSerializer
  end

  def show
    respond_with @folder, serializer: ShallowFolderSerializer
  end

  def create
    respond_with Folder.create!(folder_params), location: api_folders_url
  end

  def update
    if @folder.update_attributes! folder_params
      render json: @folder
    else
      render json: @folder, status: 422
    end
  end

  def destroy
    if @folder.destroy
      render json: @folder, status: 204
    else
      render json: @folder
    end
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end

  def find_folder
    @folder = Folder.find(params[:id])
  end
end
