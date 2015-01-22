class AddPostPersonJoinTable < ActiveRecord::Migration
  def change
    create_join_table :people, :posts
  end
end
