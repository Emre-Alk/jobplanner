class AddScrapStatusToScrapers < ActiveRecord::Migration[7.1]
  def change
    add_column :scrapers, :scrap_status, :integer, null: false, default: 0
  end
end
