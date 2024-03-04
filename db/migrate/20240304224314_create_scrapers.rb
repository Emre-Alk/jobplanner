class CreateScrapers < ActiveRecord::Migration[7.1]
  def change
    create_table :scrapers do |t|
      t.text :content

      t.timestamps
    end
  end
end
