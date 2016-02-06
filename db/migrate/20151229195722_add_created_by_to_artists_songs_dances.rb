class AddCreatedByToArtistsSongsDances < ActiveRecord::Migration
  def change 
    add_column :artists, :user_id, :integer
    add_foreign_key :artists, :users
    add_column :songs, :user_id, :integer
    add_foreign_key :songs, :users
    add_column :dances, :user_id, :integer
    add_foreign_key :dances, :users
  end
end
