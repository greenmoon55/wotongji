# -*- encoding : utf-8 -*-
class AddCategoryToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :category_id, :string
  end
end
