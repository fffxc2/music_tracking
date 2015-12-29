class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs, primary_key: 'id' do |t|
      t.string :title
      t.integer :bpm
      t.string :link

      t.timestamps null: false
    end
  end
end
