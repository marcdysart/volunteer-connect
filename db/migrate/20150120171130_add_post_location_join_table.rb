class AddPostLocationJoinTable < ActiveRecord::Migration
  def change
    create_join_table :locations, :posts
  end
end
