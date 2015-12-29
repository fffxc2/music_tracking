class AddCreatedByToArtistsSongsDances < ActiveRecord::Migration
  def change 
    add_column :artists, :author_id, :integer
    add_foreign_key :artists, :users
    add_column :songs, :author_id, :integer
    add_foreign_key :songs, :users
    add_column :dances, :author_id, :integer
    add_foreign_key :dances, :users
  end
end
