class AddDanceTable < ActiveRecord::Migration
  def change
    create_table :dances do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
