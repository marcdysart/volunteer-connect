class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :value
      t.references :user, index: true
      t.references :post, index: true

      t.timestamps
    end
  end
end
