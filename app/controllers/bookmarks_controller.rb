class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])
    @bookmark.save
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
  # No need for app/views/restaurants/destroy.html.erb
  redirect_to bookmarks_path, status: :see_other
  end
end

private

def bookmark_params
  params.require(:bookmark).permit(:name, :address, :rating)
end
