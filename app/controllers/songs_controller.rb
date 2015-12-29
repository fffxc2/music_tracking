class SongsController < ApplicationController
  before_action :artist_list, only: [:new]  

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def create
    unless user_signed_in?
      redirect_to '/songs', alert: 'Only logged in users can add songs'
    else 
      @song = Song.new(song_params)

      if @song.save
        redirect_to '/songs', notice: 'Song was successfully added.' 
      else
        render :new
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    #TODO: add artist support
    params.require(:song).permit(:title, :bpm)
  end

  def artist_list
    @artists = Artist.all
  end
end
