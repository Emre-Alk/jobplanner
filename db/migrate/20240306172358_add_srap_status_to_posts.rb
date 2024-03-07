class AddSrapStatusToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :scrap_status, :integer, default: 0, null: false
  end
end
