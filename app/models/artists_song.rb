class ArtistsSong < ActiveRecord::Base
  belongs_to :artist
  belongs_to :song

  delegate :title, :to => :song
end
