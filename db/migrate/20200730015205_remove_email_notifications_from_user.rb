class RemoveEmailNotificationsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :email_notifications
  end
end
