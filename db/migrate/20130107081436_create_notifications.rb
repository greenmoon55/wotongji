class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :text
      t.string :link
      t.boolean :read

      t.datetime :created_at
    end
  end
end
