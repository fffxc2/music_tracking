class ArtistsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.author_id = current_user.id

    if @artist.valid?
      @artist.save
      redirect_to '/artists', notice: 'Artist was successfully added.' 
    else
      render :new
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def artist_params
    params.require(:artist).permit(:name)
  end
end
