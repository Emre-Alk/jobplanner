class Post < ApplicationRecord
  has_many :post_stacks
  belongs_to :company, optional: true
  belongs_to :user
  belongs_to :scraper


  enum status: {
    pending: 0,
    applied: 10,
    rejected: 30
  }
end
