class RenameMovieIdToImdbId < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :movie_id
    remove_column :user_movies, :movie_id
    add_column :reviews, :imdb_id, :string
    add_column :user_movies, :imdb_id, :string
  end
end
