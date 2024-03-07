class Post < ApplicationRecord
  belongs_to :company, optional: true
  has_many :post_stacks
  has_many :stacks, through: :post_stacks
  belongs_to :user


  enum status: {
    pending: 0,
    applied: 10,
    rejected: 30
  }

  enum scrap_status: {
    initializing: 0,
    ongoing: 10,
    failed: 20,
    successful: 30,
  }
end
