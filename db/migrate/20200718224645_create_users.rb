class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name
      t.boolean :email_notifications, null: false, default: false

      t.timestamps
    end
  end
end
