class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.string :contract_type
      t.date :published_on
      t.text :comment
      t.text :html_source
      t.string :url
      t.text :description
      t.string :experience_years
      t.integer :status

      t.timestamps
    end
  end
end
