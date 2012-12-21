# -*- encoding : utf-8 -*-
class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end

    add_index :interests, :activity_id
    add_index :interests, :user_id
    add_index :interests, [:activity_id, :user_id], unique: true
  end
end
