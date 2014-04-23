class Api::V1::BookmarksController < ApplicationController
  respond_to :json
  before_action :find_bookmark, only: [:update, :destroy]

  def index
    respond_with Bookmark.all
  end

  def create
    respond_with Bookmark.create(bookmark_params), location: api_bookmarks_url
  end

  def update
    # respond_with here returns empty string for some dumb reason
    if @bookmark.update_attributes! bookmark_params
      render json: @bookmark
    else
      render json: @bookmark, status: 422
    end
  end

  def destroy
    if @bookmark.destroy
      render json: @bookmark, status: 204
    else
      render json: @bookmark
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:name, :url)
  end

  def find_bookmark
    @bookmark = Bookmark.find(params['id'])
  end
end
