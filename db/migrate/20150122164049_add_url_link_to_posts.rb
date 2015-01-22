class AddUrlLinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :url_link, :string
  end
end
