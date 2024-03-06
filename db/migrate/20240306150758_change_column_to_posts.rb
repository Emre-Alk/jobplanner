class ChangeColumnToPosts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :posts, :company_id, true
  end
end
