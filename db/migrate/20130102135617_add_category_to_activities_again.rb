class AddCategoryToActivitiesAgain < ActiveRecord::Migration
  def change
    add_column :activities, :category_id, :integer
  end
end
