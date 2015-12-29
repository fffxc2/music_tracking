class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def create
    unless user_signed_in?
      redirect_to '/songs', alert: 'Only logged in user can add songs'
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
end
