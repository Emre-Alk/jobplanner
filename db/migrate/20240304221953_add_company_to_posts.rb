class AddCompanyToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :company, null: false, foreign_key: true
  end
end
