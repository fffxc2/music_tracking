class Artist < ActiveRecord::Base
  has_many :artists_songs
  has_many :songs, through: :artists_songs
end
