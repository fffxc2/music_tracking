class SongsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]  

  def index
    @songs = Song.all.order(title: :asc)
  end

  def new
    @song = Song.new
    @song.artist_names = []
    @song.dance_names = []
  end

  def create
    @song = Song.new(song_params)
    @song.author_id = current_user.id
    
    if @song.valid?
      @song.save
      #now update the associations
      update_artist_ids_from_song_params
      update_dance_ids_from_song_params

      redirect_to '/songs', notice: 'Song was successfully added' 
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
    @song.artist_names = @song.artists.map(&:name).join(',')
    @song.dance_names = @song.dances.map(&:name).join(',')
  end

  def update
    @song = Song.find(params[:id])
   
    @song.assign_attributes(song_params)

    if @song.valid?
      @song.save
      #now update the associations
      update_artist_ids_from_song_params
      update_dance_ids_from_song_params

      redirect_to '/songs', notice: 'Song was updated'
    else
      render :edit
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    #Note: *_names is a comma seperated list
    params.require(:song).permit(:title, :bpm, :artist_names, :dance_names)
  end

  def update_artist_ids_from_song_params
    new_ids = []
    song_params['artist_names'].split(',').each do |name|
         a = Artist.find_by(name: name)
         #if we don't have this artist yet, just make it now
         if a.nil?
           a = Artist.new(name: name, author_id: current_user.id)
           a.save
         end
         # a should now ALWAYS contain an artist record
         new_ids << a.id
    end
    @song.artist_ids = new_ids
  end

  def update_dance_ids_from_song_params
    new_ids = []
    song_params['dance_names'].split(',').each do |name|
      d = Dance.find_by(name: name)
      #if we dont' have this dance yet, just make it now
      if d.nil?
        d = Dance.new(name: name, author_id: current_user.id)
        d.save
      end
      #a should now ALWAYS contain a dance record
      new_ids << d.id
    end
    @song.dance_ids = new_ids
  end
end
