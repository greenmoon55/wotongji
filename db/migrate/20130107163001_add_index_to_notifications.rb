class AddIndexToNotifications < ActiveRecord::Migration
  def change
    add_index :notifications, [:user_id, :created_at]
  end
end
