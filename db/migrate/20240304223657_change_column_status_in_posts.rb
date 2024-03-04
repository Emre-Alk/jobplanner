class ChangeColumnStatusInPosts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :posts, :status, false
    change_column_default :posts, :status, 0
  end
end
