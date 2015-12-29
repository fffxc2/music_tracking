class Song < ActiveRecord::Base
  has_many :artists_songs
  has_many :artists, through: :artists_songs

  #validate :has_at_least_one_artist
  validates :title, uniqueness: { scope: :artists,
    message: "Song already exists" }

  attr_accessor(:artist_names)
 
  private
  def has_at_least_one_artist
    errors.add(:artists, 'Requires at least one artist') if artists.empty?
  end
end
