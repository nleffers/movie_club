class RemoveMovieFromTables < ActiveRecord::Migration[5.2]
  def change
    remove_index :user_movies, :movie_id
    remove_index :reviews, :movie_id
  end
end
