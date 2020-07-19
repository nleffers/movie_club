class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.belongs_to :movie
      t.integer :rating
      t.string :title
      t.text :blog

      t.timestamps
    end
  end
end
