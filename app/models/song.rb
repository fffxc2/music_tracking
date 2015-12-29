class Song < ActiveRecord::Base
  has_many :artists_songs
  has_many :artists, through: :artists_songs

  has_many :dances_songs
  has_many :dances, through: :dances_songs

  validate :has_at_least_one_artist
  validate :unique_title_for_artist
  validate :valid_youtube_link

  validates :author_id, presence: true, inclusion: { in: User.all.map(&:id) }

  attr_accessor :artist_names
  attr_accessor :dance_names
  attr_accessor :video_id
 
  private
  def has_at_least_one_artist
    errors.add(:song, 'requires at least one artist') if artist_names.empty?
  end

  def unique_title_for_artist
    artist_names.split(',').each do |name|
      a = Artist.find_by(name: name)
      unless a.nil? #if we didn't find a match we will create it later
        a.artists_songs.each do |artist_song|
          duplicate_song = (artist_song.title == title) && (artist_song.song_id != id)
          errors.add(:song, "with this name already present for #{a.name}") if duplicate_song
        end
      end
    end
  end

  def valid_youtube_link
    youtube_regex = /(?:https?\:\/\/)?(?:www\.)?(?:youtube.com|youtu.be)\/(?:watch\?v=|v\/)?(?<video_id>[A-z0-9]+)/ 
    youtube_match = youtube_regex.match(link)
    errors.add(:song, "requires the youtube link to be valid") if !link.nil? && youtube_match.nil?
  end
end
