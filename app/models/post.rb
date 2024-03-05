class Post < ApplicationRecord
  has_many :post_stacks
  belongs_to :company
  belongs_to :user

  enum status: {
    pending: 0,
    applied: 10,
    rejected: 30
  }
end
