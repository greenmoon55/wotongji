# -*- encoding : utf-8 -*-
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.references :activity
      t.references :user

      t.timestamps
    end
    add_index :comments, :activity_id
    add_index :comments, :user_id
  end
end
