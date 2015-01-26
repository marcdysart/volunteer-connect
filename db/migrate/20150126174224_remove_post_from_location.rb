class RemovePostFromLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :post_id, :integer
  end
end
