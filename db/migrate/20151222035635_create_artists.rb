class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists, primary_key: 'id' do |t|
      t.string :name

      t.timestamps null: false
    end

    add_column :songs, :artist_id, :int
  end
end
