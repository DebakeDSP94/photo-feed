class StaticPagesController < ApplicationController
  require "flickr"

  def index
    @flickr = Flickr.new
    if params[:username].present?
      response = @flickr.people.findByUsername username: params[:username]
      @photos = @flickr.people.getPhotos user_id: response["nsid"]
    elsif params[:tags].present?
      @photos = @flickr.photos.search tags: params[:tags], safesearch: 1
    else
      @photos = @flickr.photos.getRecent
    end
  end
end
