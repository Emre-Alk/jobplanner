class Post < ApplicationRecord
  has_many :post_stacks
  belongs_to :company
  belongs_to :user
end
