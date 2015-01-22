class AddPostPeriodJoinTable < ActiveRecord::Migration
  def change
    create_join_table :periods, :posts
  end
end
