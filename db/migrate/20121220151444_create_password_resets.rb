class CreatePasswordResets < ActiveRecord::Migration
  def change
    create_table :password_resets do |t|
      t.string :token
			t.datetime :created_at
    end
  end
end
