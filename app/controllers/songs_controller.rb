class SongsController < ApplicationController
  before_action :artist_list, only: [:new]  
  before_action :logged_out_redirect, only: [:new, :create, :edit, :update]

  def index
    @songs = Song.all.order(title: :asc)
  end

  def new
    @song = Song.new
    @song.artist_names = []
  end

  def create
    @song = Song.new(song_params)
    
    song_params['artist_names'].split(',').each do |name|
      a = Artist.all.named(name)
      errors.add(:artist, "name was ambiguous") if a.count > 1
    end

    if @song.valid?
      @song.save
      #now update the associations
      update_artist_ids_from_song_params

      redirect_to '/songs', notice: 'Song was successfully added' 
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
    @song.artist_names = @song.artists.map(&:name).join(',')
  end

  def update
    @song = Song.find(params[:id])

    #manually maping this back instead of update attributes to deal with maping artist names back and forth
    #I should probably try to pass a hash into the js, so it's value is the id's and it just displays the names

    song_params['artist_names'].split(',').each do |name|
      a = Artist.all.named(name)
      errors.add(:artist, "name was ambiguous") if a.count > 1
    end 
   
    @song.assign_attributes(song_params)

    if @song.valid?
      @song.save
      #now update the associations
      update_artist_ids_from_song_params

      redirect_to '/songs', notice: 'Song was updated'
    else
      render :edit
    end
  end
  
  def logged_out_redirect
    redirect_to '/songs', alert: 'Only logged in users can do that' unless user_signed_in?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    #Note: artist_names is a comma seperated list
    params.require(:song).permit(:title, :bpm, :artist_names)
  end

  def artist_list
    @artists = Artist.all
  end

  def update_artist_ids_from_song_params
    new_ids = []
    song_params['artist_names'].split(',').each do |name|
         a = Artist.find_by(name: name)
         #if we don't have this artist yet, just make it now
         if a.nil?
           a = Artist.new(name: name)
           a.save
         end
         # a should now ALWAYS contain an artist record
         new_ids << a.id
    end
    @song.artist_ids = new_ids
  end
end
