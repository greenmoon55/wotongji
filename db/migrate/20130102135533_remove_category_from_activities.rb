class RemoveCategoryFromActivities < ActiveRecord::Migration
  def up
    remove_column :activities, :category_id
  end

  def down
    add_column :activities, :category_id, :string
  end
end
