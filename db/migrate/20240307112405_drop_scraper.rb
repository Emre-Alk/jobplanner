class DropScraper < ActiveRecord::Migration[7.1]
  def change
    drop_table :scrapers
  end
end
