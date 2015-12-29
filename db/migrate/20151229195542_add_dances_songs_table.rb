class AddDancesSongsTable < ActiveRecord::Migration
  def change
    create_table :dances_songs do |t|
      t.belongs_to :dance, index: true
      t.belongs_to :song, index: true
    end
  end
end
