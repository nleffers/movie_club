class AddRatingToUserMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :user_movies, :rating, :integer
  end
end
