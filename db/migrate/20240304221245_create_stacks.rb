class CreateStacks < ActiveRecord::Migration[7.1]
  def change
    create_table :stacks do |t|
      t.string :name

      t.timestamps
    end
  end
end
