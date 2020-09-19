class AddWebsiteurlToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :websiteurl, :text
  end
end
