class StaticPagesController < ApplicationController
  require "flickr"

  def index
    @flickr = Flickr.new
    if params[:user_id].present?
      @photos = @flickr.people.getPhotos user_id: params[:user_id]
    elsif params[:tags].present?
      @photos = @flickr.photos.search tags: params[:tags], safesearch: 1
    else
      @photos = @flickr.photos.getRecent
    end
  end
end
