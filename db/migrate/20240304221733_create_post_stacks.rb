class CreatePostStacks < ActiveRecord::Migration[7.1]
  def change
    create_table :post_stacks do |t|
      t.references :post, null: false, foreign_key: true
      t.references :stack, null: false, foreign_key: true

      t.timestamps
    end
  end
end
