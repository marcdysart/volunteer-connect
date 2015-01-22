class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.date :start
      t.date :end
      t.references :post, index: true

      t.timestamps
    end
  end
end
