class RemovePostFromPersonAndAddUserToPerson < ActiveRecord::Migration
  def change
    change_table :people do |t|
      t.remove :post_id, :integer
      t.references :user, index: true
    end
  end
end
