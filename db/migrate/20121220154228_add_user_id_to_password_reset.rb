# -*- encoding : utf-8 -*-
class AddUserIdToPasswordReset < ActiveRecord::Migration
  def change
    add_column :password_resets, :user_id, :int
  end
end
