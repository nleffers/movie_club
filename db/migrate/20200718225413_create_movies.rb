class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.integer :rating, null: false, default: 0
      t.integer :rating_count, null: false, default: 0

      t.timestamps
    end
  end
end
