class AddArtistsSongsTable < ActiveRecord::Migration
  def change
    create_table :artists_songs, id: false do |t|
      t.belongs_to :artist, index: true
      t.belongs_to :song, index: true
    end
  end
end
