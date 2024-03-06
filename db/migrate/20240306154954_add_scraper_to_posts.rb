class AddScraperToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :scraper, null: false, foreign_key: true
  end
end
