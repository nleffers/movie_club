class CreateUserMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :user_movies do |t|
      t.belongs_to :movie
      t.belongs_to :user
      t.integer :rating
    end
  end
end
