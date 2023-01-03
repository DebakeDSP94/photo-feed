class StaticPagesController < ApplicationController
  require "flickr"

  def index
    @flickr = Flickr.new
    if params[:user_id].present?
      @photos = @flickr.people.getPhotos user_id: params[:user_id]
    end
  end
end
