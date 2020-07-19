class CreateMoviesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_users, id: false do |t|
      t.belongs_to :movie
      t.belongs_to :user
    end
  end
end
