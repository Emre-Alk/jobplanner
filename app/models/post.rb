class Post < ApplicationRecord
  has_many :post_stacks
  belongs_to :company
  belongs_to :user

  enum status: {
    candidate: 0,
    candidated: 1,
  }

end
