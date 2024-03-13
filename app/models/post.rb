class Post < ApplicationRecord
  belongs_to :company, optional: true
  has_many :post_stacks, dependent: :destroy
  has_many :stacks, through: :post_stacks
  belongs_to :user
  has_rich_text :content

  enum status: {
    pending: 0,
    applied: 10,
    interviewed: 20,
    rejected: 30
  }

  def color
    case status
    when "pending"
      "#eab308"
    when "applied"
      "#38a169"
    when "interviewed"
      "#94C1EA"
    when "rejected"
      "#e53e3e"
    end
  end

  enum scrap_status: {
    initializing: 0,
    ongoing: 10,
    failed: 20,
    successful: 30,
  }
end
