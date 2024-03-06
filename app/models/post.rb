class Post < ApplicationRecord
  belongs_to :company, optional: true
  has_many :stacks, through: :post_stacks
  belongs_to :user
  belongs_to :scraper


  enum status: {
    pending: 0,
    applied: 10,
    rejected: 30
  }
end
