class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    unless user_signed_in?
      redirect_to '/artists', alert: 'Only logged in users can add songs'
    else
      @artist = Artist.new(artist_params)

      if @artist.save
        redirect_to '/artists', notice: 'Artist was successfully added.' 
      else
        render :new
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def artist_params
    params.require(:artist).permit(:name)
  end
end
