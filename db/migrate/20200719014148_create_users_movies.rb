class CreateUsersMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :users_movies, id: false do |t|
      t.belongs_to :users
      t.belongs_to :movies
    end
  end
end
