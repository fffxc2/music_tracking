class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to '/songs', notice: 'Song was successfully added.' 
    else
      render :new
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    #TODO: add artist support
    params.require(:song).permit(:title, :bpm)
  end
end
