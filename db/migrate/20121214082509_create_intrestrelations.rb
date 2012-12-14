class CreateIntrestrelations < ActiveRecord::Migration
  def change
    create_table :intrestrelations do |t|
      t.integer :activity_id
      t.integer :user_id

      t.timestamps
    end

    add_index :intrestrelations, :activity_id
    add_index :intrestrelations, :user_id
    add_index :intrestrelations, [:activity_id, :user_id], unique: true
  end
end
